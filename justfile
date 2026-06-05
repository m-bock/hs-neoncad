DOC_IMGS_DIR := "out/doc-imgs"

gen-doc-imgs:
    # rm -rf {{DOC_IMGS_DIR}}
    mkdir -p {{DOC_IMGS_DIR}}
    cabal test
    for img in {{DOC_IMGS_DIR}}/*.scad; do \
        echo "Generating image for $img"; \
        openscad --imgsize=4000,4000 -o tmp.png "$img"; \
        convert tmp.png -resize 100x100 "${img%.scad}.png"; \
        rm tmp.png; \
    done

gen-docs:
    cabal haddock