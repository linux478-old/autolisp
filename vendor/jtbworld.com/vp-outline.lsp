;;; vp-outline.lsp
;;;
;;; Creates a polyline in modelspace that
;;; has the outline of the selected viewport.
;;; Supports clipped viewports. polyline is supported
;;; ellipse, spline, region and circle not supported at this point
;;; If vp-outline is called when in mspace it detects
;;; the active viewport.
;;;
;;; c:vp-outline
;;;
;;; By Jimmy Bergmark
;;; Copyright (C) 1997-2013 JTB World, All Rights Reserved
;;; Website: www.jtbworld.com
;;; E-mail: info@jtbworld.com
;;;
;;; 2000-04-10
;;; 2003-11-19 Added support for drawing the outline in other ucs/view than world/current
;;;
;;; 2006-04-06 Added support for twisted views Tom Beauford
;;; 2013-06-08 Added support for circular viewports
;;;
;;; Should work on AutoCAD 2000 and newer
(vl-load-com)

(defun dxf (n ed) (cdr (assoc n ed)))

(defun ax:List->VariantArray (lst)
  (vlax-Make-Variant
    (vlax-SafeArray-Fill
      (vlax-Make-SafeArray
	vlax-vbDouble
	(cons 0 (- (length lst) 1))
      )
      lst
    )
  )
)

(defun c:vp-outline (/ ad ss ent pl plist xy n vpbl vpur msbl msur ven vpno ok
		     circ)
  (setq ad (vla-get-activedocument (vlax-get-acad-object)))
  (if (= (getvar "tilemode") 0)
    (progn
      (if (= (getvar "cvport") 1)
	(progn
	  (if (setq ss (ssget ":E:S" '((0 . "VIEWPORT"))))
	    (progn (setq ent (ssname ss 0))
		   (setq vpno (dxf 69 (entget ent)))
		   (vla-Display (vlax-ename->vla-object ent) :vlax-true)
		   (vla-put-mspace ad :vlax-true) ; equal (command "._mspace")
 ; this to ensure trans later is working on correct viewport
		   (setvar "cvport" vpno)
 ;              (vla-put-mspace ad :vlax-false) ; equal (command "._pspace")
		   (setq ok T)
		   (setq ss nil)
	    )
	  )
	)
	(setq ent (vlax-vla-object->ename (vla-get-activepviewport ad))
	      ok  T
	)
      )
      (if ok
	(progn (setq circle nil)
	       (setq ven (vlax-ename->vla-object ent))
	       (if (/= 1 (logand 1 (dxf 90 (entget ent)))) ; detect perspective
		 (progn	(if (= (vla-get-clipped ven) :vlax-false)
			  (progn ; not clipped
			    (vla-getboundingbox ven 'vpbl 'vpur)
			    (setq vpbl	(trans (vlax-safearray->list vpbl) 3 2)
				  msbl	(trans vpbl 2 1)
				  msbl	(trans msbl 1 0)
				  vpur	(trans (vlax-safearray->list vpur) 3 2)
				  msur	(trans vpur 2 1)
				  msur	(trans msur 1 0)
				  vpbr	(list (car vpur) (cadr vpbl) 0)
				  msbr	(trans vpbr 2 1)
				  msbr	(trans msbr 1 0)
				  vpul	(list (car vpbl) (cadr vpur) 0)
				  msul	(trans vpul 2 1)
				  msul	(trans msul 1 0)
				  plist	(list (car msbl)
					      (cadr msbl)
					      (car msbr)
					      (cadr msbr)
					      (car msur)
					      (cadr msur)
					      (car msul)
					      (cadr msul)
					)
			    )
			  )
			  (progn ; clipped
			    (setq pl (entget (dxf 340 (entget ent))))
			    (if	(= (dxf 0 pl) "CIRCLE")
			      (setq circle T)
			      (progn (setq plist (vla-get-coordinates
						   (vlax-ename->vla-object (dxf -1 pl))
						 )
					   plist (vlax-safearray->list (vlax-variant-value plist))
					   n	 0
					   pl	 nil
				     )
				     (repeat (/ (length plist) 2)
				       (setq xy	(trans (list (nth n plist) (nth (1+ n) plist)) 3 2)
					     xy	(trans xy 2 1)
					     xy	(trans xy 1 0)
					     pl	(cons (car xy) pl)
					     pl	(cons (cadr xy) pl)
					     n	(+ n 2)
				       )
				     )
				     (setq plist (reverse pl))
			      )
			    )
			  )
			)
			(if circle
			  (vla-AddCircle
			    (vla-get-ModelSpace ad)
			    (ax:List->VariantArray
			      (trans (trans (trans (dxf 10 pl) 1 0) 2 1) 3 2)
			    )
			    (/ (dxf 40 pl) (caddr (trans '(0 0 1) 2 3)))
			  )
			  (vla-Put-Closed
			    (vla-AddLightWeightPolyline
			      (vla-get-ModelSpace ad)
			      (ax:List->VariantArray plist)
			    )
			    :vlax-True
			  )
			)
		 )
	       )
	)
      )
    )
  )
  (if ss
    (vla-put-mspace ad :vlax-false)
  ) ; equal (command "._pspace"))
  (princ)
)
