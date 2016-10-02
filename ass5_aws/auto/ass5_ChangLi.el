(TeX-add-style-hook
 "ass5_ChangLi"
 (lambda ()
   (TeX-add-to-alist 'LaTeX-provided-class-options
                     '(("article" "10pt" "a4paper")))
   (TeX-add-to-alist 'LaTeX-provided-package-options
                     '(("mcode" "framed" "numbered" "autolinebreaks" "useliterate") ("graphicx" "pdftex")))
   (TeX-run-style-hooks
    "latex2e"
    "article"
    "art10"
    "amssymb"
    "amsmath"
    "cite"
    "mcode"
    "graphicx")
   (LaTeX-add-labels
    "fig:q2vs"
    "fig:q3tradeoff"
    "fig:q3recovered")
   (LaTeX-add-bibliographies))
 :latex)

