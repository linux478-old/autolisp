(princ "\nLoading MP-SS")
(princ ".")
(defun MP:SS->load ()
  (princ "")
)
(princ ".")
(defun MP:SS->SS ( lSS )
  (if (null lSS)
    (ssadd)
    lSS
  )
)
(princ ".")
(defun MP:SS->~SS ( oSS )
  (MP:SS->loop oSS 'entdel)
)
(princ ".")
(defun MP:SS->get ( oSS iItem)
  (ssname oSS iItem)
)
(princ ".")
(defun MP:SS->add ( oSS eEntity)
  (ssadd eEntity oSS)
)
(princ ".")
(defun MP:SS->del ( oSS eEntity)
  (ssdel eEntity oSS )
)
(princ ".")
(defun MP:SS->length ( oSS )
  (sslength oSS)
)
(princ ".")
(defun MP:SS->centerPoint ( oSS )
  (setq bb (MP:SS->boundingBox oSS))
  (list 
    (/ (+ (car (car bb)) (car (cadr bb))) 2)
    (/ (+ (cadr (car bb)) (cadr (cadr bb))) 2)
  )
)
(princ ".")
;; Selection Set Bounding Box  -  Lee Mac
;; Returns a list of the lower-left and upper-right WCS coordinates of a
;; rectangular frame bounding all objects in a supplied selection set.
;; sel - [sel] Selection set for which to return bounding box
(defun MP:SS->getBoundingBox ( oSS / LM:ssboundingbox )
  (defun LM:ssboundingbox ( sel / idx llp ls1 ls2 obj urp )
      (repeat (setq idx (sslength sel))
	  (setq obj (vlax-ename->vla-object (ssname sel (setq idx (1- idx)))))
	  (if (and (vlax-method-applicable-p obj 'getboundingbox)
		   (not (vl-catch-all-error-p (vl-catch-all-apply 'vla-getboundingbox (list obj 'llp 'urp))))
	      )
	      (setq ls1 (cons (vlax-safearray->list llp) ls1)
		    ls2 (cons (vlax-safearray->list urp) ls2)
	      )
	  )
      )
      (if (and ls1 ls2)
	  (mapcar '(lambda ( a b ) (apply 'mapcar (cons a b))) '(min max) (list ls1 ls2))
      )
  )
  (LM:ssboundingbox oSS)
)
(princ ".")
(defun MP:SS->loop ( oSS fProcess )
  (setq cnt (MP:SS->length oSS)
  )
  (repeat cnt
    (setq cnt (1- cnt)
          e   (ssname oSS cnt)
    )
    (eval (list fProcess e))
  )
  (princ)
)
(princ ".")
(defun MP:SS->toList ( oSS / LM:ss->ent )
  ;;--------------=={ SelectionSet -> Entities }==--------------;;
  ;;                                                            ;;
  ;;  Converts a SelectionSet to a list of Entities             ;;
  ;;------------------------------------------------------------;;
  ;;  Author: Lee Mac, Copyright © 2011 - www.lee-mac.com       ;;
  ;;------------------------------------------------------------;;
  ;;  Arguments:                                                ;;
  ;;  ss - Valid SelectionSet (Pickset)                         ;;
  ;;------------------------------------------------------------;;
  ;;  Returns:  List of Entity names, else nil                  ;;
  ;;------------------------------------------------------------;;
  (defun LM:ss->ent ( ss / i l )
    (if ss
        (repeat (setq i (sslength ss))
          (setq l (cons (ssname ss (setq i (1- i))) l))
        )
    )
  )
  (LM:ss->ent oSS)
)
(princ " [Done]")
(princ)

