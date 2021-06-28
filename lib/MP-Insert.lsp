(princ "\nLoading MP-Insert")
(princ ".")
(defun MP:Insert->load ()
  (MP:Con->load)
  (princ "")
)
(princ ".")
(defun MP:Insert->_Default ()
  (list
    (MP:Con->setEntity "Insert")
    (MP:Con->setName "Point")
    (MP:Con->setInsertPoint (list 0 0 0))
    (MP:Con->setScaleX 1)
    (MP:Con->setScaleY 1)
    (MP:Con->setScaleZ 1)
    (MP:Con->setRotationDeg 0)
  )  
)
(princ ".")
(defun MP:Insert->Insert ( eEntity )
  (if (null eEntity)
    (MP:Insert->_Default)
    (MP:DXF->DXF eEntity)
  )
)
(princ ".")
(defun MP:Insert->~Insert ( oInsert )
  nil
)
(princ ".")
(defun MP:Insert->setName ( oInsert sName )
  (subst (cons 2 sName) (assoc 2 oInsert) oInsert)
)
(princ ".")
(defun MP:Insert->setInsertPoint ( oInsert pInsertion )
  (subst (cons 10 pInsertion) (assoc 10 oInsert) oInsert)
)
(princ ".")
(defun MP:Insert->setScale ( oInsert rScale )
  (subst (cons 41 rScale) (assoc 41 oInsert) oInsert)
  (subst (cons 42 rScale) (assoc 42 oInsert) oInsert)
  (subst (cons 43 rScale) (assoc 43 oInsert) oInsert)
)
(princ ".")
(defun MP:Insert->setRotationDeg ( oInsert rRotation )
  (subst
    (cons 50 (* pi (/ rRotation 180.0)))
    (assoc 50 oInsert)
    oInsert
  )
)
(princ ".")
(defun MP:Insert->setRotationRad ( oInsert rRotation )
  (subst 
    (cons 50 rRotation) 
    (assoc 50 oInsert)
    oInsert
  )
)
(princ ".")
(defun MP:Insert->put ( oInsert )
  (entmakex oInsert)
)
(princ ".")
(defun MP:Insert->getDynamicBlockPropertyValue ( vBlock sProperty
                                               /
                                               LM:getdynpropvalue
                                               )
;; Get Dynamic Block Property Value  -  Lee Mac
;; Returns the value of a Dynamic Block property (if present)
;; blk - [vla] VLA Dynamic Block Reference object
;; prp - [str] Dynamic Block property name (case-insensitive)
  (defun LM:getdynpropvalue ( blk prp )
    (setq prp (strcase prp))
    (vl-some '(lambda ( x ) (if (= prp (strcase (vla-get-propertyname x)))
      (vlax-get x 'value)))
        (vlax-invoke blk 'getdynamicblockproperties)
    )
  )
  (LM:getdynpropvalue vBlock sProperty)
)
(princ ".")
;; Set Dynamic Block Property Value  -  Lee Mac
;; Modifies the value of a Dynamic Block property (if present)
;; blk - [vla] VLA Dynamic Block Reference object
;; prp - [str] Dynamic Block property name (case-insensitive)
;; val - [any] New value for property
;; Returns: [any] New value if successful, else nil
(defun MP:Insert->setDynamicPropertyValue ( vBlock sProperty aValue
                                          /
					    LM:setdynpropvalue
                                          )
  (defun LM:setdynpropvalue ( blk prp val )
      (setq prp (strcase prp))
      (vl-some
	 '(lambda ( x )
	      (if (= prp (strcase (vla-get-propertyname x)))
		  (progn
		      (vla-put-value x (vlax-make-variant val (vlax-variant-type (vla-get-value x))))
		      (cond (val) (t))
		  )
	      )
	  )
	  (vlax-invoke blk 'getdynamicblockproperties)
      )
  )
  (LM:setdynpropvalue vBlock sProperty aValue)
)
(princ ".")
(defun MP:Insert->getDynamicProperties ( vBlock
                                       /
                                         LM:getdynprops
                                       )
;; Get Dynamic Block Properties  -  Lee Mac
;; Returns an association list of Dynamic Block properties & values.
;; blk - [vla] VLA Dynamic Block Reference object
;; Returns: [lst] Association list of ((<prop> . <value>) ... )

  (defun LM:getdynprops ( blk )
      (mapcar '(lambda ( x ) (cons (vla-get-propertyname x) (vlax-get x 'value)))
	  (vlax-invoke blk 'getdynamicblockproperties)
      )
  )
  (LM:getdynprops vBlock)
)
(princ ".")
(defun MP:Insert->setDynamicProperties ( vBlock lValues
                                       /
                                         LM:setdynprops
                                       )
;; Set Dynamic Block Properties  -  Lee Mac
;; Modifies values of Dynamic Block properties using a supplied association list.
;; blk - [vla] VLA Dynamic Block Reference object
;; lst - [lst] Association list of ((<Property> . <Value>) ... )
;; Returns: nil

  (defun LM:setdynprops ( blk lst / itm )
      (setq lst (mapcar '(lambda ( x ) (cons (strcase (car x)) (cdr x))) lst))
      (foreach x (vlax-invoke blk 'getdynamicblockproperties)
	  (if (setq itm (assoc (strcase (vla-get-propertyname x)) lst))
	      (vla-put-value x (vlax-make-variant (cdr itm) (vlax-variant-type (vla-get-value x))))
	  )
      )
  )
  (LM:setdynprops vBlock lValues)
)
(princ ".")
(defun MP:Insert->getDynamicPropertyAllowedValues ( vBlock lValues 
                                                  /
                                                    LM:getdynpropallowedvalues
                                                  )
;; Get Dynamic Block Property Allowed Values  -  Lee Mac
;; Returns the allowed values for a specific Dynamic Block property.
;; blk - [vla] VLA Dynamic Block Reference object
;; prp - [str] Dynamic Block property name (case-insensitive)
;; Returns: [lst] List of allowed values for property, else nil if no restrictions

  (defun LM:getdynpropallowedvalues ( blk prp )
      (setq prp (strcase prp))
      (vl-some '(lambda ( x ) (if (= prp (strcase (vla-get-propertyname x))) (vlax-get x 'allowedvalues)))
	  (vlax-invoke blk 'getdynamicblockproperties)
      )
  )
  (LM:getdynpropallowedvalues vBlock lValues)
)
(princ ".")
(defun MP:Insert->toggleDynamicFlipState ( vBlock
                                         /
                                           LM:toggleflipstate
                                         )
;; Toggle Dynamic Block Flip State  -  Lee Mac
;; Toggles the Flip parameter if present in a supplied Dynamic Block.
;; blk - [vla] VLA Dynamic Block Reference object
;; Return: [int] New Flip Parameter value

  (defun LM:toggleflipstate ( blk )
      (vl-some
	 '(lambda ( prp / rtn )
	      (if (equal '(0 1) (vlax-get prp 'allowedvalues))
		  (progn
		      (vla-put-value prp (vlax-make-variant (setq rtn (- 1 (vlax-get prp 'value))) vlax-vbinteger))
		      rtn
		  )
	      )
	  )
	  (vlax-invoke blk 'getdynamicblockproperties)
      )
  )
  (LM:toggleflipstate vBlock)
)
(princ ".")
(defun MP:Insert->getDynamicVisibilityParameterName ( vBlock
                                                    /
                                                      LM:getvisibilityparametername
                                                    )
;; Get Visibility Parameter Name  -  Lee Mac
;; Returns the name of the Visibility Parameter of a Dynamic Block (if present)
;; blk - [vla] VLA Dynamic Block Reference object
;; Returns: [str] Name of Visibility Parameter, else nil

  (defun LM:getvisibilityparametername ( blk / vis )  
      (if
	  (and
	      (vlax-property-available-p blk 'effectivename)
	      (setq blk
		  (vla-item
		      (vla-get-blocks (vla-get-document blk))
		      (vla-get-effectivename blk)
		  )
	      )
	      (= :vlax-true (vla-get-isdynamicblock blk))
	      (= :vlax-true (vla-get-hasextensiondictionary blk))
	      (setq vis
		  (vl-some
		     '(lambda ( pair )
			  (if
			      (and
				  (= 360 (car pair))
				  (= "BLOCKVISIBILITYPARAMETER" (cdr (assoc 0 (entget (cdr pair)))))
			      )
			      (cdr pair)
			  )
		      )
		      (dictsearch
			  (vlax-vla-object->ename (vla-getextensiondictionary blk))
			  "ACAD_ENHANCEDBLOCK"
		      )
		  )
	      )
	  )
	  (cdr (assoc 301 (entget vis)))
      )
  )
  (LM:getvisibilityparametername vBlock)
)
(princ ".")
(defun MP:Insert->getDynamicVisibilityState ( vBlock
                                            /
                                              LM:getvisibilitystate
                                            )
;; Get Dynamic Block Visibility State  -  Lee Mac
;; Returns the value of the Visibility Parameter of a Dynamic Block (if present)
;; blk - [vla] VLA Dynamic Block Reference object
;; Returns: [str] Value of Visibility Parameter, else nil

  (defun LM:getvisibilitystate ( blk / vis )
      (if (setq vis (MP:Insert->getDynamicVisibilityParameterName blk))
	  (MP:Insert->getDynamicProperties blk vis)
      )
  )
  (MP:getvisibilitystate vBlock)
)
(princ ".")
(defun MP:Insert->setDynamicVisibilityState ( vBlock sValue
                                            /
                                              LM:SetVisibilityState
                                            )
;; Set Dynamic Block Visibility State  -  Lee Mac
;; Sets the Visibility Parameter of a Dynamic Block (if present) to a specific value (if allowed)
;; blk - [vla] VLA Dynamic Block Reference object
;; val - [str] Visibility State Parameter value
;; Returns: [str] New value of Visibility Parameter, else nil

  (defun LM:SetVisibilityState ( blk val / vis )
      (if
	  (and
	      (setq vis (MP:Insert->getDynamicBlockPropertyValue blk val))
	      (member (strcase val) (mapcar 'strcase (MP:Insert->getDynamicPropertyAllowedValues blk vis)))
	  )
	  (MP:Insert->setDynamicPropertyValue blk vis val)
      )
  )
  (LM:SetVisibilityState vBlock sValue)
)
(princ " [Done]")
(princ)

