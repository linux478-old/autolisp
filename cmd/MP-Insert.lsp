(MP:Insert->load)
(MP:SS->load)

(princ "\nLoading C:MP-Insert")
(princ ".")
(defun C:MP:replaceSelectionSetWithBaitStation ()
  (prompt "\nThings to be replace with bait station.")
  (setq ss (ssget))
  (setq bb (MP:SS->getBoundingBox ss))
  (setq pt (list (/ (+ (car (car bb)) (car (cadr bb))) 2)
                     (/ (+ (cadr (car bb)) (cadr (cadr bb))) 2)
	   )
  )
  (setq oldattdia (getvar 'attdia))
  (setvar 'attdia 0)
  (setq ids (mapcar '(lambda (x)
                   (setq rtn ""
                         d (entget x)
                         en (assoc 0 d)
                         name (cdr en)
                   )
                   (if (member name (list "MTEXT" "TEXT"))
                     (setq rtn (cdr (assoc 1 d)))
                   )
                   rtn
                 )
                 (MP:SS->toList ss)
          )
        )
(setq id (apply 'strcat ids))
      
      (command "-insert"
               "ID SYMBOLS" ; name of the block
               "_NON" ; temporary turning off osnap
               pt
               "1" ; scale in the x
               "1" ; scale in the y
               "0" ; rotation
               id
      )
    (command "erase" ss "")
    (MP:Insert->setDynamicVisibilityState (vlax-ename->vla-object (entlast)) "BAIT STATION")
    (setvar 'attdia oldattdia)
)
(princ " [Done]")
(princ)
