(princ "\nLoading MP-Layer ")
(princ ".")
(defun MP:Layer->load ()
  (princ "")
)
(princ ".")
(defun MP:Layer->get (sName)
  (if (null sName)
    (setq layer (tblobjname "LAYER" (getvar 'clayer)))
    (setq layer (tblobjname "LAYER" sName))
  )
  (if (not (null layer))
    (entget layer)
    nil
  )
)
(princ ".")
(defun MP:Layer->getColor (obj)
  (cdr (assoc 62 obj))
)
(princ ".")
(defun MP:Layer->getName (obj)
  (cdr (assoc 2 obj))
)
(princ ".")
(defun MP:Layer->isFrozen (obj)
  (MP:_Layer->query oLayer 70 1)
)
(princ ".")
(defun MP:Layer->isLock (oLayer)
  (MP:_Layer->query oLayer 70 4)
)
(princ ".")
(defun MP:Layer->isOff (oLayer)
  (< (cdr (assoc 62 oLayer)) 0)
)
(princ ".")
(defun MP:Layer->isOn (oLayer)
  (> (cdr (assoc 62 oLayer)) 0)
)
(princ ".")
(defun MP:Layer->isPlotable (oLayer)
  (> (cdr (assoc 290 oLayer)) 0)
)
(princ ".")
(defun MP:Layer->isPresent (name)
  (tblsearch "layer" name)
);defun
(princ ".")
(defun MP:Layer->set (oLayer)
  (entmod oLayer)
);defun
(princ ".")
(defun MP:Layer->setColor (oLayer iColor)
  (subst
    (cons 62 iColor)
    (assoc 62 oLayer)
    oLayer
  )
);defun
(princ ".")
(defun MP:Layer->setName (oLayer iName)
  (subst
    (cons 2 iName)
    (assoc 2 oLayer)
    oLayer
  )
);defun
(princ ".")
(defun MP:Layer->setPrefix (oLayer iName)
  (subst
    (cons 2 (strcat iName (MP:Layer->getName oLayer)))
    (assoc 2 oLayer)
    oLayer
  )
);defun
(princ ".")
(defun MP:Layer->setSuffix (oLayer iName)
  (subst
    (cons 2 (strcat (MP:Layer->getName oLayer) iName))
    (assoc 2 oLayer)
    oLayer
  )
);defun
(princ ".")
(defun MP:Layer->toggleFrozen (oLayer)
  (subst
    (cons 70 (boole 6 (cdr (assoc 70 oLayer)) 1) )
    (assoc 70 oLayer)
    oLayer
  )
);defun
(princ ".")
(defun MP:Layer->toggleLock (oLayer)
  (subst
    (cons 70 (boole 6 (cdr (assoc 70 oLayer)) 4) )
    (assoc 70 oLayer)
    oLayer
  )
);defun
(princ ".")
(defun MP:Layer->toggleOn (oLayer)
  (subst
    (cons 62 (* (cdr (assoc 70 oLayer)) -1))
    (assoc 62 oLayer)
    oLayer
  )
);defun
(princ ".")
(defun MP:_Layer->query (oLayer iName aValue)
  (= (boole 1 (cdr (assoc iName oLayer)) aValue) aValue)
)
(princ " [Done]")
(princ)

