(TeX-add-style-hook
 "ass4_ChangLi_20160918011633"
 (lambda ()
   (TeX-add-to-alist 'LaTeX-provided-class-options
                     '(("article" "10pt" "a4paper")))
   (TeX-run-style-hooks
    "latex2e"
    "article"
    "art10"
    "amssymb"
    "amsmath")
   (LaTeX-add-bibliographies
    "ass4_ChangLi"))
 :latex)

