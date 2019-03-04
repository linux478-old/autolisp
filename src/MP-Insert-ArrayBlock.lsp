;; Get Attribute Values  -  Lee Mac
;; Returns an association list of attributes present in the supplied block.
;; blk - [vla] VLA Block Reference Object
;; Returns: [lst] Association list of ((<tag> . <value>) ... )

(if 
  (and
    (setq blkname (getstring "\nEnter Blockname: "))
    (setq numattrib (getint "\nEnter number of attribute(s): "))
    (setq pt1 (getpoint "\nEnter Insert Point: "))
    (setq attdia (getvar 'attdia))
  )
  (progn
    (setvar 'attdia 0)
    (command "insert" 
           blkname
           "_NON"
           pt1 
           "1" 
           "1" 
           "0" 
           (repeat numattrib (command (getstring "\nEnter value: ")))
    )
    (mapcar '(lambda (x) (command x)) value)
    (setvar 'attdia attdia)
    (if 
      (and
        (setq PT2 (getpoint "\nINSERT POINT: "))
        (setq dx (- (car pt2)(car pt1)))
        (setq dy (- (cadr pt2)(cadr pt1)))
        (setq dz (- (caddr pt2)(caddr pt1)))
      )
      (while PT2 
        (setvar 'attdia 0)
        (command "insert" 
                 blkname
                 "_NON"
                 pt2 
                 "1" 
                 "1" 
                 "0" 
                 (repeat numattrib (command (getstring "\nEnter value: ")))
        )
        (setvar 'attdia attdia)
        (setq PT2 (list (+ (car pt2) dx)(+ (cadr pt2) dy)(+ (caddr pt2) dz)))
      )
    )
  )
)
