(TeX-add-style-hook
 "ass3_ChangLi"
 (lambda ()
   (TeX-add-to-alist 'LaTeX-provided-class-options
                     '(("article" "10pt" "a4paper")))
   (TeX-run-style-hooks
    "latex2e"
    "article"
    "art10"
    "amssymb"
    "amsmath")
   (LaTeX-add-labels
    "eq:1")
   (LaTeX-add-bibliographies))
 :latex)

