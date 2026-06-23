DOC_IMGS_DIR := "doc-imgs"
DOCS_DIR := "docs"
EXAMPLES_DIR := "examples-out"
DOC_IMG_SIZE := "100"
EXAMPLE_IMG_SIZE := "512"

_render-scad dir size:
    for img in {{dir}}/*.scad; do \
        png="${img%.scad}.png"; \
        stl="${img%.scad}.stl"; \
        if git ls-files --error-unmatch "$img" >/dev/null 2>&1 \
            && git diff --quiet HEAD -- "$img" \
            && [ -f "$png" ] \
            && [ -f "$stl" ]; then \
            echo "Skipping $img (unchanged)"; \
            continue; \
        fi; \
        echo "Generating image for $img"; \
        openscad --imgsize=4000,4000 -o tmp.png "$img"; \
        convert tmp.png -resize {{size}}x{{size}} "$png"; \
        rm tmp.png; \
        echo "Generating STL for $img"; \
        openscad -o "$stl" "$img"; \
    done

clean:
    rm -rf {{DOC_IMGS_DIR}}
    rm -rf {{DOCS_DIR}}
    rm -rf {{EXAMPLES_DIR}}

gen-doc-imgs:
    mkdir -p {{DOC_IMGS_DIR}}
    DOC_IMGS_DIR={{DOC_IMGS_DIR}} cabal test
    just _render-scad {{DOC_IMGS_DIR}} {{DOC_IMG_SIZE}}

gen-docs:
    cabal haddock --haddock-output-dir={{DOCS_DIR}}

push-docs:
    npx gh-pages -d {{DOCS_DIR}}

gen-examples:
    mkdir -p {{EXAMPLES_DIR}}
    EXAMPLES_DIR={{EXAMPLES_DIR}} cabal run neoncad-examples
    just _render-scad {{EXAMPLES_DIR}} {{EXAMPLE_IMG_SIZE}}