DOC_IMGS_DIR := "doc-imgs"
DOCS_DIR := "docs"
EXAMPLES_DIR := "examples-out"
DOC_IMG_SIZE := "100"
EXAMPLE_IMG_SIZE := "512"
SKIP_PNG := env_var_or_default("SKIP_PNG", "true")
SKIP_STL := env_var_or_default("SKIP_STL", "true")
NO_SKIP := env_var_or_default("NO_SKIP", "false")
VIEWPORTS_FILE := env_var_or_default("VIEWPORTS_FILE", "examples/viewports.json")

dev:
    find examples src test -name '*.hs' | SKIP_PNG=true SKIP_STL=true entr just gen-examples

_render-scad dir size:
    SKIP_PNG={{SKIP_PNG}} SKIP_STL={{SKIP_STL}} NO_SKIP={{NO_SKIP}} VIEWPORTS_FILE={{VIEWPORTS_FILE}} \
        python3 scripts/render-scad.py {{dir}} {{size}}

clean:
    rm -rf {{DOC_IMGS_DIR}}
    rm -rf {{DOCS_DIR}}
    rm -rf {{EXAMPLES_DIR}}

gen-doc-imgs:
    mkdir -p {{DOC_IMGS_DIR}}
    DOC_IMGS_DIR={{DOC_IMGS_DIR}} cabal test
    SKIP_PNG={{SKIP_PNG}} SKIP_STL={{SKIP_STL}} NO_SKIP={{NO_SKIP}} just _render-scad {{DOC_IMGS_DIR}} {{DOC_IMG_SIZE}}

gen-docs:
    cabal haddock --haddock-output-dir={{DOCS_DIR}}

push-docs:
    npx gh-pages -d {{DOCS_DIR}}

gen-examples:
    mkdir -p {{EXAMPLES_DIR}}
    EXAMPLES_DIR={{EXAMPLES_DIR}} cabal run neoncad-examples
    SKIP_PNG={{SKIP_PNG}} SKIP_STL={{SKIP_STL}} NO_SKIP={{NO_SKIP}} just _render-scad {{EXAMPLES_DIR}} {{EXAMPLE_IMG_SIZE}}

watch-examples:
    find examples src test -name '*.hs' | SKIP_PNG={{SKIP_PNG}} SKIP_STL={{SKIP_STL}} entr just gen-examples