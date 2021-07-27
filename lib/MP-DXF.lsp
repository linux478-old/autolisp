(princ "\nLoading MP-DXF ")
(princ ".")
(defun MP:DXF->load ()
  (princ "")
)
(princ ".")
;|

=== MP:DXF->new (eName) ===

  *Description:*
    Gets the list of cons for the element
  
  *Parameters:*
    eEntity - entity name
    
  *Returns:*
    An association list containing the entity definition of eName

|;
(defun MP:DXF->new (eName)
  (entget eName)
)
(princ ".")
(defun MP:DXF->getValueByNumber (n d)
  (cdr (assoc n d))
)
(princ ".")
(defun MP:DXF->getEntity(d)
  (cdr (assoc 0 d))
)
(princ ".")
(defun MP:DXF->getInsert(d)
  (cdr (assoc 10 d))
)
(princ ".")
(defun MP:DXF->getLayer(d)
  (cdr (assoc 8 d))
)
(princ ".")
(defun MP:DXF->getColor(d)
  (cdr (assoc 62 d))
)
(princ " [Done]")
(princ)
