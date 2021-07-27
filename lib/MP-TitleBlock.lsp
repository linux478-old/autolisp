(princ "\nLoading MP-TBlock ")
(princ ".")
(defun MP:TBlock->load ()
  (princ "")
)
(princ ".")
(defun MP:TBlock->get ()
  (ssget "all" (list
                 '(0 . "insert")
                 '(10 0 0 0)
                 (cons 410 (MP:Layout->getName))
               )
  )
); defun
(princ ".")
(defun MP:TBlock->isAtOrigin ( )
  (and
    (setq ss (MP:TBlock->get))
    (= 1 (sslength ss))
    (setq en (ssname ss 0))
    (setq ed (entget en))
    (or
      (= (cdr (assoc 2 ed)) (MP:TBlock->getName))
      (= (MP:Insert->getEffectivename en) (MP:TBlock->getName))
    )
  )
); defun
(princ ".")
(defun MP:TBlock->getName ()
  "SHEET D"
); defun
(princ ".")
(defun MP:TBlock->getRevision ()
  (LM:vl-getattributevalue 
    (vlax-ename->vla-object (ssname (MP:TBlock->get) 0))
    "Revision"
  )
); defun
(princ " [Done]")
(princ)
