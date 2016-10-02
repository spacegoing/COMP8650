(TeX-add-style-hook
 "ass5_ChangLi"
 (lambda ()
   (TeX-add-to-alist 'LaTeX-provided-class-options
                     '(("article" "10pt" "a4paper")))
   (TeX-run-style-hooks
    "latex2e"
    "article"
    "art10"
    "amssymb"
    "amsmath"
    "cite")
   (LaTeX-add-bibliographies))
 :latex)

