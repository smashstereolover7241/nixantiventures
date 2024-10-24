;;1st layer top row
(keyboard-translate ?^ ?^)
(keyboard-translate ?1 ?1)
(keyboard-translate ?2 ?2)
(keyboard-translate ?3 ?3)
(keyboard-translate ?4 ?4)
(keyboard-translate ?5 ?5)
(keyboard-translate ?6 ?6)
(keyboard-translate ?7 ?7)
(keyboard-translate ?8 ?8)
(keyboard-translate ?9 ?9)
(keyboard-translate ?0 ?0)
(keyboard-translate ?- ?ß)
(keyboard-translate ?` ?´)

;;1st layer second row
(keyboard-translate ?k ?q)
(keyboard-translate ?. ?w)
(keyboard-translate ?o ?e)
(keyboard-translate ?, ?r)
(keyboard-translate ?y ?t)
(keyboard-translate ?v ?z)
(keyboard-translate ?g ?u)
(keyboard-translate ?c ?i)
(keyboard-translate ?l ?o)
(keyboard-translate ?ß ?p)
(keyboard-translate ?z ?ü)
(keyboard-translate ?´ ?+)

;;1st layer third row
(keyboard-translate ?h ?a)
(keyboard-translate ?a ?s)
(keyboard-translate ?e ?d)
(keyboard-translate ?i ?f)
(keyboard-translate ?u ?g)
(keyboard-translate ?d ?h)
(keyboard-translate ?t ?j)
(keyboard-translate ?r ?k)
(keyboard-translate ?n ?l)
(keyboard-translate ?s ?ö)
(keyboard-translate ?f ?ä)
;;(keyboard-translate ?# nil)

;;1st layer forth row
;;(keyboard-translate ?< nil)
(keyboard-translate ?x ?y)
(keyboard-translate ?q ?x)
(keyboard-translate ?ä ?c)
(keyboard-translate ?ü ?v)
(keyboard-translate ?ö ?b)
(keyboard-translate ?b ?n)
(keyboard-translate ?p ?m)
(keyboard-translate ?w ?,)
(keyboard-translate ?m ?.)
(keyboard-translate ?j ?-)

;; not continuing like this, foud the fix at https://emacs.stackexchange.com/questions/19761/how-to-fix-wrong-type-argument-characterp-134217782
;;(keyboard-translate(event-convert-list '(super ?y)) (event-convert-list '(super ?y)))
;;(keyboard-translate (head-x 1 '(kbd "M-q")) (head-x 1 '(kbd "M-x")))


;;alt

;;1st layer top row
(define-key key-translation-map (kbd "M-^") (kbd "M-^"))
(define-key key-translation-map (kbd "M-1") (kbd "M-1"))
(define-key key-translation-map (kbd "M-2") (kbd "M-2"))
(define-key key-translation-map (kbd "M-3") (kbd "M-3"))
(define-key key-translation-map (kbd "M-4") (kbd "M-4"))
(define-key key-translation-map (kbd "M-5") (kbd "M-5"))
(define-key key-translation-map (kbd "M-6") (kbd "M-6"))
(define-key key-translation-map (kbd "M-7") (kbd "M-7"))
(define-key key-translation-map (kbd "M-8") (kbd "M-8"))
(define-key key-translation-map (kbd "M-9") (kbd "M-9"))
(define-key key-translation-map (kbd "M-0") (kbd "M-0"))
(define-key key-translation-map (kbd "M-\-") (kbd "M-ß"))
(define-key key-translation-map (kbd "M-`") (kbd "M-´"))

;;1st layer second row
(define-key key-translation-map (kbd "M-k") (kbd "M-q"))
(define-key key-translation-map (kbd "M-.") (kbd "M-w"))
(define-key key-translation-map (kbd "M-o") (kbd "M-e"))
(define-key key-translation-map (kbd "M-,") (kbd "M-r"))
(define-key key-translation-map (kbd "M-y") (kbd "M-t"))
(define-key key-translation-map (kbd "M-v") (kbd "M-z"))
(define-key key-translation-map (kbd "M-g") (kbd "M-u"))
(define-key key-translation-map (kbd "M-c") (kbd "M-i"))
(define-key key-translation-map (kbd "M-l") (kbd "M-o"))
(define-key key-translation-map (kbd "M-ß") (kbd "M-p"))
(define-key key-translation-map (kbd "M-z") (kbd "M-ü"))
(define-key key-translation-map (kbd "M-´") (kbd "M-+"))
;;non keys omitted

;;1st layer third row
(define-key key-translation-map (kbd "M-h") (kbd "M-a"))
(define-key key-translation-map (kbd "M-a") (kbd "M-s"))
(define-key key-translation-map (kbd "M-e") (kbd "M-d"))
(define-key key-translation-map (kbd "M-i") (kbd "M-f"))
(define-key key-translation-map (kbd "M-u") (kbd "M-g"))
(define-key key-translation-map (kbd "M-d") (kbd "M-h"))
(define-key key-translation-map (kbd "M-t") (kbd "M-j"))
(define-key key-translation-map (kbd "M-r") (kbd "M-k"))
(define-key key-translation-map (kbd "M-n") (kbd "M-l"))
(define-key key-translation-map (kbd "M-s") (kbd "M-ö"))
(define-key key-translation-map (kbd "M-f") (kbd "M-ä"))
;;non keys omitted

;;1st layer forth row
(define-key key-translation-map (kbd "M-x") (kbd "M-y"))
(define-key key-translation-map (kbd "M-q") (kbd "M-x"))
(define-key key-translation-map (kbd "M-ä") (kbd "M-c"))
(define-key key-translation-map (kbd "M-ü") (kbd "M-v"))
(define-key key-translation-map (kbd "M-ö") (kbd "M-b"))
(define-key key-translation-map (kbd "M-b") (kbd "M-n"))
(define-key key-translation-map (kbd "M-p") (kbd "M-m"))
(define-key key-translation-map (kbd "M-w") (kbd "M-,"))
(define-key key-translation-map (kbd "M-m") (kbd "M-."))
(define-key key-translation-map (kbd "M-j") (kbd "M--"))
;;you know the drill and so do I

;;super key wooow

;;1st layer top row
(define-key key-translation-map (kbd "s-^") (kbd "s-^"))
(define-key key-translation-map (kbd "s-1") (kbd "s-1"))
(define-key key-translation-map (kbd "s-2") (kbd "s-2"))
(define-key key-translation-map (kbd "s-3") (kbd "s-3"))
(define-key key-translation-map (kbd "s-4") (kbd "s-4"))
(define-key key-translation-map (kbd "s-5") (kbd "s-5"))
(define-key key-translation-map (kbd "s-6") (kbd "s-6"))
(define-key key-translation-map (kbd "s-7") (kbd "s-7"))
(define-key key-translation-map (kbd "s-8") (kbd "s-8"))
(define-key key-translation-map (kbd "s-9") (kbd "s-9"))
(define-key key-translation-map (kbd "s-0") (kbd "s-0"))
(define-key key-translation-map (kbd "s-\-") (kbd "s-ß"))
(define-key key-translation-map (kbd "s-`") (kbd "s-´"))

;;1st layer second row
(define-key key-translation-map (kbd "s-k") (kbd "s-q"))
(define-key key-translation-map (kbd "s-.") (kbd "s-w"))
(define-key key-translation-map (kbd "s-o") (kbd "s-e"))
(define-key key-translation-map (kbd "s-,") (kbd "s-r"))
(define-key key-translation-map (kbd "s-y") (kbd "s-t"))
(define-key key-translation-map (kbd "s-v") (kbd "s-z"))
(define-key key-translation-map (kbd "s-g") (kbd "s-u"))
(define-key key-translation-map (kbd "s-c") (kbd "s-i"))
(define-key key-translation-map (kbd "s-l") (kbd "s-o"))
(define-key key-translation-map (kbd "s-ß") (kbd "s-p"))
(define-key key-translation-map (kbd "s-z") (kbd "s-ü"))
(define-key key-translation-map (kbd "s-´") (kbd "s-+"))
;;non keys omitted

;;1st layer third row
(define-key key-translation-map (kbd "s-h") (kbd "s-a"))
(define-key key-translation-map (kbd "s-a") (kbd "s-s"))
(define-key key-translation-map (kbd "s-e") (kbd "s-d"))
(define-key key-translation-map (kbd "s-i") (kbd "s-f"))
(define-key key-translation-map (kbd "s-u") (kbd "s-g"))
(define-key key-translation-map (kbd "s-d") (kbd "s-h"))
(define-key key-translation-map (kbd "s-t") (kbd "s-j"))
(define-key key-translation-map (kbd "s-r") (kbd "s-k"))
(define-key key-translation-map (kbd "s-n") (kbd "s-l"))
(define-key key-translation-map (kbd "s-s") (kbd "s-ö"))
(define-key key-translation-map (kbd "s-f") (kbd "s-ä"))
;;non keys omitted

;;1st layer forth row
(define-key key-translation-map (kbd "s-x") (kbd "s-y"))
(define-key key-translation-map (kbd "s-q") (kbd "s-x"))
(define-key key-translation-map (kbd "s-ä") (kbd "s-c"))
(define-key key-translation-map (kbd "s-ü") (kbd "s-v"))
(define-key key-translation-map (kbd "s-ö") (kbd "s-b"))
(define-key key-translation-map (kbd "s-b") (kbd "s-n"))
(define-key key-translation-map (kbd "s-p") (kbd "s-m"))
(define-key key-translation-map (kbd "s-w") (kbd "s-,"))
(define-key key-translation-map (kbd "s-m") (kbd "s-."))
(define-key key-translation-map (kbd "s-j") (kbd "s--"))
;;you know the drill and so do I


;;control

;;1st layer top row
(define-key key-translation-map (kbd "C-^") (kbd "C-^"))
(define-key key-translation-map (kbd "C-1") (kbd "C-1"))
(define-key key-translation-map (kbd "C-2") (kbd "C-2"))
(define-key key-translation-map (kbd "C-3") (kbd "C-3"))
(define-key key-translation-map (kbd "C-4") (kbd "C-4"))
(define-key key-translation-map (kbd "C-5") (kbd "C-5"))
(define-key key-translation-map (kbd "C-6") (kbd "C-6"))
(define-key key-translation-map (kbd "C-7") (kbd "C-7"))
(define-key key-translation-map (kbd "C-8") (kbd "C-8"))
(define-key key-translation-map (kbd "C-9") (kbd "C-9"))
(define-key key-translation-map (kbd "C-0") (kbd "C-0"))
(define-key key-translation-map (kbd "C-\-") (kbd "C-ß"))
(define-key key-translation-map (kbd "C-`") (kbd "C-´"))

;;1st layer second row
(define-key key-translation-map (kbd "C-k") (kbd "C-q"))
;;(define-key key-translation-map (kbd "C-.") (kbd "C-w"))
(define-key key-translation-map (kbd "C-o") (kbd "C-e"))
(define-key key-translation-map (kbd "C-,") (kbd "C-r"))
(define-key key-translation-map (kbd "C-y") (kbd "C-t"))
(define-key key-translation-map (kbd "C-v") (kbd "C-z"))
(define-key key-translation-map (kbd "C-g") (kbd "C-u"))
(define-key key-translation-map (kbd "C-c") (kbd "C-i"))
(define-key key-translation-map (kbd "C-l") (kbd "C-o"))
(define-key key-translation-map (kbd "C-ß") (kbd "C-p"))
(define-key key-translation-map (kbd "C-z") (kbd "C-ü"))
(define-key key-translation-map (kbd "C-´") (kbd "C-+"))
;;non keys omitted

;;1st layer third row
(define-key key-translation-map (kbd "C-h") (kbd "C-a"))
(define-key key-translation-map (kbd "C-a") (kbd "C-s"))
(define-key key-translation-map (kbd "C-e") (kbd "C-d"))
(define-key key-translation-map (kbd "C-i") (kbd "C-f"))
(define-key key-translation-map (kbd "C-u") (kbd "C-g"))
(define-key key-translation-map (kbd "C-d") (kbd "C-h"))
(define-key key-translation-map (kbd "C-t") (kbd "C-j"))
(define-key key-translation-map (kbd "C-r") (kbd "C-k"))
(define-key key-translation-map (kbd "C-n") (kbd "C-l"))
(define-key key-translation-map (kbd "C-s") (kbd "C-ö"))
(define-key key-translation-map (kbd "C-f") (kbd "C-ä"))
;;non keys omitted

;;1st layer forth row
(define-key key-translation-map (kbd "C-x") (kbd "C-y"))
(define-key key-translation-map (kbd "C-q") (kbd "C-x"))
(define-key key-translation-map (kbd "C-ä") (kbd "C-c"))
(define-key key-translation-map (kbd "C-ü") (kbd "C-v"))
(define-key key-translation-map (kbd "C-ö") (kbd "C-b"))
(define-key key-translation-map (kbd "C-b") (kbd "C-n"))
(define-key key-translation-map (kbd "C-p") (kbd "C-m"))
(define-key key-translation-map (kbd "C-w") (kbd "C-,"))
;;(define-key key-translation-map (kbd "C-m") (kbd "C-."))
(define-key key-translation-map (kbd "C-j") (kbd "C--"))
;;you know the drill and so do I

;;alt-super

;;1st layer top row
(define-key key-translation-map (kbd "M-s-^") (kbd "M-s-^"))
(define-key key-translation-map (kbd "M-s-1") (kbd "M-s-1"))
(define-key key-translation-map (kbd "M-s-2") (kbd "M-s-2"))
(define-key key-translation-map (kbd "M-s-3") (kbd "M-s-3"))
(define-key key-translation-map (kbd "M-s-4") (kbd "M-s-4"))
(define-key key-translation-map (kbd "M-s-5") (kbd "M-s-5"))
(define-key key-translation-map (kbd "M-s-6") (kbd "M-s-6"))
(define-key key-translation-map (kbd "M-s-7") (kbd "M-s-7"))
(define-key key-translation-map (kbd "M-s-8") (kbd "M-s-8"))
(define-key key-translation-map (kbd "M-s-9") (kbd "M-s-9"))
(define-key key-translation-map (kbd "M-s-0") (kbd "M-s-0"))
(define-key key-translation-map (kbd "M-s-\-") (kbd "M-s-ß"))
(define-key key-translation-map (kbd "M-s-`") (kbd "M-s-´"))

;;1st layer second row
(define-key key-translation-map (kbd "M-s-k") (kbd "M-s-q"))
(define-key key-translation-map (kbd "M-s-.") (kbd "M-s-w"))
(define-key key-translation-map (kbd "M-s-o") (kbd "M-s-e"))
(define-key key-translation-map (kbd "M-s-,") (kbd "M-s-r"))
(define-key key-translation-map (kbd "M-s-y") (kbd "M-s-t"))
(define-key key-translation-map (kbd "M-s-v") (kbd "M-s-z"))
(define-key key-translation-map (kbd "M-s-g") (kbd "M-s-u"))
(define-key key-translation-map (kbd "M-s-c") (kbd "M-s-i"))
(define-key key-translation-map (kbd "M-s-l") (kbd "M-s-o"))
(define-key key-translation-map (kbd "M-s-ß") (kbd "M-s-p"))
(define-key key-translation-map (kbd "M-s-z") (kbd "M-s-ü"))
(define-key key-translation-map (kbd "M-s-´") (kbd "M-s-+"))
;;non keys omitted

;;1st layer third row
(define-key key-translation-map (kbd "M-s-h") (kbd "M-s-a"))
(define-key key-translation-map (kbd "M-s-a") (kbd "M-s-s"))
(define-key key-translation-map (kbd "M-s-e") (kbd "M-s-d"))
(define-key key-translation-map (kbd "M-s-i") (kbd "M-s-f"))
(define-key key-translation-map (kbd "M-s-u") (kbd "M-s-g"))
(define-key key-translation-map (kbd "M-s-d") (kbd "M-s-h"))
(define-key key-translation-map (kbd "M-s-t") (kbd "M-s-j"))
(define-key key-translation-map (kbd "M-s-r") (kbd "M-s-k"))
(define-key key-translation-map (kbd "M-s-n") (kbd "M-s-l"))
(define-key key-translation-map (kbd "M-s-s") (kbd "M-s-ö"))
(define-key key-translation-map (kbd "M-s-f") (kbd "M-s-ä"))
;;non keys omitted

;;1st layer forth row
(define-key key-translation-map (kbd "M-s-x") (kbd "M-s-y"))
(define-key key-translation-map (kbd "M-s-q") (kbd "M-s-x"))
(define-key key-translation-map (kbd "M-s-ä") (kbd "M-s-c"))
(define-key key-translation-map (kbd "M-s-ü") (kbd "M-s-v"))
(define-key key-translation-map (kbd "M-s-ö") (kbd "M-s-b"))
(define-key key-translation-map (kbd "M-s-b") (kbd "M-s-n"))
(define-key key-translation-map (kbd "M-s-p") (kbd "M-s-m"))
(define-key key-translation-map (kbd "M-s-w") (kbd "M-s-,"))
(define-key key-translation-map (kbd "M-s-m") (kbd "M-s-."))
(define-key key-translation-map (kbd "M-s-j") (kbd "M-s--"))
;;you know the drill and so do I

;;super-ctrl

;;1st layer top row
(define-key key-translation-map (kbd "C-s-^") (kbd "C-s-^"))
(define-key key-translation-map (kbd "C-s-1") (kbd "C-s-1"))
(define-key key-translation-map (kbd "C-s-2") (kbd "C-s-2"))
(define-key key-translation-map (kbd "C-s-3") (kbd "C-s-3"))
(define-key key-translation-map (kbd "C-s-4") (kbd "C-s-4"))
(define-key key-translation-map (kbd "C-s-5") (kbd "C-s-5"))
(define-key key-translation-map (kbd "C-s-6") (kbd "C-s-6"))
(define-key key-translation-map (kbd "C-s-7") (kbd "C-s-7"))
(define-key key-translation-map (kbd "C-s-8") (kbd "C-s-8"))
(define-key key-translation-map (kbd "C-s-9") (kbd "C-s-9"))
(define-key key-translation-map (kbd "C-s-0") (kbd "C-s-0"))
(define-key key-translation-map (kbd "C-s-\-") (kbd "C-s-ß"))
(define-key key-translation-map (kbd "C-s-`") (kbd "C-s-´"))

;;1st layer second row
(define-key key-translation-map (kbd "C-s-k") (kbd "C-s-q"))
(define-key key-translation-map (kbd "C-s-.") (kbd "C-s-w"))
(define-key key-translation-map (kbd "C-s-o") (kbd "C-s-e"))
(define-key key-translation-map (kbd "C-s-,") (kbd "C-s-r"))
(define-key key-translation-map (kbd "C-s-y") (kbd "C-s-t"))
(define-key key-translation-map (kbd "C-s-v") (kbd "C-s-z"))
(define-key key-translation-map (kbd "C-s-g") (kbd "C-s-u"))
(define-key key-translation-map (kbd "C-s-c") (kbd "C-s-i"))
(define-key key-translation-map (kbd "C-s-l") (kbd "C-s-o"))
(define-key key-translation-map (kbd "C-s-ß") (kbd "C-s-p"))
(define-key key-translation-map (kbd "C-s-z") (kbd "C-s-ü"))
(define-key key-translation-map (kbd "C-s-´") (kbd "C-s-+"))
;;non keys omitted

;;1st layer third row
(define-key key-translation-map (kbd "C-s-h") (kbd "C-s-a"))
(define-key key-translation-map (kbd "C-s-a") (kbd "C-s-s"))
(define-key key-translation-map (kbd "C-s-e") (kbd "C-s-d"))
(define-key key-translation-map (kbd "C-s-i") (kbd "C-s-f"))
(define-key key-translation-map (kbd "C-s-u") (kbd "C-s-g"))
(define-key key-translation-map (kbd "C-s-d") (kbd "C-s-h"))
(define-key key-translation-map (kbd "C-s-t") (kbd "C-s-j"))
(define-key key-translation-map (kbd "C-s-r") (kbd "C-s-k"))
(define-key key-translation-map (kbd "C-s-n") (kbd "C-s-l"))
(define-key key-translation-map (kbd "C-s-s") (kbd "C-s-ö"))
(define-key key-translation-map (kbd "C-s-f") (kbd "C-s-ä"))
;;non keys omitted

;;1st layer forth row
(define-key key-translation-map (kbd "C-s-x") (kbd "C-s-y"))
(define-key key-translation-map (kbd "C-s-q") (kbd "C-s-x"))
(define-key key-translation-map (kbd "C-s-ä") (kbd "C-s-c"))
(define-key key-translation-map (kbd "C-s-ü") (kbd "C-s-v"))
(define-key key-translation-map (kbd "C-s-ö") (kbd "C-s-b"))
(define-key key-translation-map (kbd "C-s-b") (kbd "C-s-n"))
(define-key key-translation-map (kbd "C-s-p") (kbd "C-s-m"))
(define-key key-translation-map (kbd "C-s-w") (kbd "C-s-,"))
(define-key key-translation-map (kbd "C-s-m") (kbd "C-s-."))
(define-key key-translation-map (kbd "C-s-j") (kbd "C-s--"))
;;you know the drill and so do I


;;control-mod
;;1st layer top row
(define-key key-translation-map (kbd "C-M-^") (kbd "C-M-^"))
(define-key key-translation-map (kbd "C-M-1") (kbd "C-M-1"))
(define-key key-translation-map (kbd "C-M-2") (kbd "C-M-2"))
(define-key key-translation-map (kbd "C-M-3") (kbd "C-M-3"))
(define-key key-translation-map (kbd "C-M-4") (kbd "C-M-4"))
(define-key key-translation-map (kbd "C-M-5") (kbd "C-M-5"))
(define-key key-translation-map (kbd "C-M-6") (kbd "C-M-6"))
(define-key key-translation-map (kbd "C-M-7") (kbd "C-M-7"))
(define-key key-translation-map (kbd "C-M-8") (kbd "C-M-8"))
(define-key key-translation-map (kbd "C-M-9") (kbd "C-M-9"))
(define-key key-translation-map (kbd "C-M-0") (kbd "C-M-0"))
(define-key key-translation-map (kbd "C-M-\-") (kbd "C-M-ß"))
(define-key key-translation-map (kbd "C-M-`") (kbd "C-M-´"))

;;1st layer second row
(define-key key-translation-map (kbd "C-M-k") (kbd "C-M-q"))
(define-key key-translation-map (kbd "C-M-.") (kbd "C-M-w"))
(define-key key-translation-map (kbd "C-M-o") (kbd "C-M-e"))
(define-key key-translation-map (kbd "C-M-,") (kbd "C-M-r"))
(define-key key-translation-map (kbd "C-M-y") (kbd "C-M-t"))
(define-key key-translation-map (kbd "C-M-v") (kbd "C-M-z"))
(define-key key-translation-map (kbd "C-M-g") (kbd "C-M-u"))
(define-key key-translation-map (kbd "C-M-c") (kbd "C-M-i"))
(define-key key-translation-map (kbd "C-M-l") (kbd "C-M-o"))
(define-key key-translation-map (kbd "C-M-ß") (kbd "C-M-p"))
(define-key key-translation-map (kbd "C-M-z") (kbd "C-M-ü"))
(define-key key-translation-map (kbd "C-M-´") (kbd "C-M-+"))
;;non keys omitted

;;1st layer third row
(define-key key-translation-map (kbd "C-M-h") (kbd "C-M-a"))
(define-key key-translation-map (kbd "C-M-a") (kbd "C-M-s"))
(define-key key-translation-map (kbd "C-M-e") (kbd "C-M-d"))
(define-key key-translation-map (kbd "C-M-i") (kbd "C-M-f"))
(define-key key-translation-map (kbd "C-M-u") (kbd "C-M-g"))
(define-key key-translation-map (kbd "C-M-d") (kbd "C-M-h"))
(define-key key-translation-map (kbd "C-M-t") (kbd "C-M-j"))
(define-key key-translation-map (kbd "C-M-r") (kbd "C-M-k"))
(define-key key-translation-map (kbd "C-M-n") (kbd "C-M-l"))
(define-key key-translation-map (kbd "C-M-s") (kbd "C-M-ö"))
(define-key key-translation-map (kbd "C-M-f") (kbd "C-M-ä"))
;;non keys omitted

;;1st layer forth row
(define-key key-translation-map (kbd "C-M-x") (kbd "C-M-y"))
(define-key key-translation-map (kbd "C-M-q") (kbd "C-M-x"))
(define-key key-translation-map (kbd "C-M-ä") (kbd "C-M-c"))
(define-key key-translation-map (kbd "C-M-ü") (kbd "C-M-v"))
(define-key key-translation-map (kbd "C-M-ö") (kbd "C-M-b"))
(define-key key-translation-map (kbd "C-M-b") (kbd "C-M-n"))
(define-key key-translation-map (kbd "C-M-p") (kbd "C-M-m"))
(define-key key-translation-map (kbd "C-M-w") (kbd "C-M-,"))
(define-key key-translation-map (kbd "C-M-m") (kbd "C-M-."))
(define-key key-translation-map (kbd "C-M-j") (kbd "C-M--"))
;;you know the drill and so do I

;;AAAAAAAAAAAAAAAAAAAAnd now for uppercase

;;1st layer top row
(keyboard-translate ?\ˇ ?\°)
(keyboard-translate ?\° ?\!)
(keyboard-translate ?\§ ?\")
(keyboard-translate ?\ℓ ?\§)
(keyboard-translate ?\» ?\$)
(keyboard-translate ?\« ?\%)
(keyboard-translate ?\$ ?\&)
(keyboard-translate ?\€ ?\/)
(keyboard-translate ?\„ ?\()
(keyboard-translate ?\“ ?\))
(keyboard-translate ?\” ?\=)
(keyboard-translate ?\— ?\?)
(keyboard-translate ?¸ ?\`)

;;1st layer second row
(keyboard-translate ?K ?Q)
(keyboard-translate ?• ?W)
(keyboard-translate ?O ?E)
(keyboard-translate ?– ?R)
(keyboard-translate ?Y ?T)
(keyboard-translate ?V ?Z)
(keyboard-translate ?G ?U)
(keyboard-translate ?C ?I)
(keyboard-translate ?L ?O)
(keyboard-translate ?ẞ ?P)
(keyboard-translate ?Z ?Ü)
;;(keyboard-translate ?\~ ?\*)

;;1st layer third row
(keyboard-translate ?H ?A)
(keyboard-translate ?A ?S)
(keyboard-translate ?E ?D)
(keyboard-translate ?I ?F)
(keyboard-translate ?U ?G)
(keyboard-translate ?D ?H)
(keyboard-translate ?T ?J)
(keyboard-translate ?R ?K)
(keyboard-translate ?N ?L)
(keyboard-translate ?S ?Ö)
(keyboard-translate ?F ?Ä)
;;(keyboard-translate ?# nil)

;;1st layer forth row
;;(keyboard-translate ?< nil)
(keyboard-translate ?X ?Y)
(keyboard-translate ?Q ?X)
(keyboard-translate ?Ä ?C)
(keyboard-translate ?Ü ?V)
(keyboard-translate ?Ö ?B)
(keyboard-translate ?B ?N)
(keyboard-translate ?P ?M)
(keyboard-translate ?W ?;)
(keyboard-translate ?M ?:)
(keyboard-translate ?J ?_)

;;TODO: Weitermachen

;; translate when inputting

(require 'quail)

(defvar qwertz-koy-title "q"
  "Have the translation happen")

(defun qwertz-koy ()
  "Set 'qwertz-koy' input method."
  (interactive)
  (set-input-method "qwertz-koy"))

(quail-define-package
 "qwertz-koy" "German" qwertz-koy-title nil
 "emacs qwertz to koy"
 nil t t t t nil nil nil nil nil t)

(quail-define-rules

;;lowercase

;;1st layer top row

 ("^" ?^)
 ("1" ?1)
 ("2" ?2)
 ("3" ?3)
 ("4" ?4)
 ("5" ?5)
 ("6" ?6)
 ("7" ?7)
 ("8" ?8)
 ("9" ?9)
 ("0" ?0)
 ("ß" ?-)
 ("´" ?`)

 ;;1st layer second row
 ("q" ?k)
 ("w" ?.)
 ("e" ?o)
 ("r" ?,)
 ("t" ?y)
 ("z" ?v)
 ("u" ?g)
 ("i" ?c)
 ("o" ?l)
 ("p" ?ß)
 ("ü" ?z)

 ;;1st layer third row
 ("a" ?h)
 ("s" ?a)
 ("d" ?e)
 ("f" ?i)
 ("g" ?u)
 ("h" ?d)
 ("j" ?t)
 ("k" ?r)
 ("l" ?n)
 ("ö" ?s)
 ("ä" ?f)
 ;;("#" ?nil)

 ;;1st layer forth row
 ;;("<" ?nil)
 ("y" ?x)
 ("x" ?q)
 ("c" ?ä)
 ("v" ?ü)
 ("b" ?ö)
 ("n" ?b)
 ("m" ?p)
 ("," ?w)
 ("." ?m)
 ("-" ?j)

 ;;uuuuuuuuuuuupercase

 ;;1st layer top row

;;  ("\°" ?\ˇ)
;;  ("\!" ?\°)
;;  ("\"" ?\§)
;;  ("\§" ?\ℓ)
;;  ("\$" ?\»)
;;  ("\%" ?\«)
;;  ("\&" ?\$)
;;  ("\/" ?\€)
;;  ("\(" ?\„)
;;  ("\)" ?\“)
;;  ("\=" ?\”)
;;  ("\?" ?\—)
;;  ("\`" ?\¸)

  ;;1st layer second row
  ("Q" ?K)
  ("W" ?•)
  ("E" ?O)
  ("R" ?–)
  ("T" ?Y)
  ("Z" ?V)
  ("U" ?G)
  ("I" ?C)
  ("O" ?L)
  ("P" ?ẞ)
  ("Ü" ?Z)


  ;;1st layer third row
  ("A" ?H)
  ("S" ?A)
  ("D" ?E)
  ("F" ?I)
  ("G" ?U)
  ("H" ?D)
  ("J" ?T)
  ("K" ?R)
  ("L" ?N)
  ("Ö" ?S)
  ("Ä" ?F)
  ;;("#" ?nil)

  ;;1st layer forth row
  ;;("<" ?nil)
  ("Y" ?X)
  ("X" ?Q)
  ("C" ?Ä)
  ("V" ?Ü)
  ("B" ?Ö)
  ("N" ?B)
  ("M" ?P)

 )
(provide 'qwertz-koy)

;; now run it
(qwertz-koy)

(defun normal-input()
  "make input be normal again"
  (interactive)
  (set-input-method "normal-input"))

(quail-define-package
 "normal-input" "German" "make input normal again!" nil
 "emacs normalize input"
 nil t t t t nil nil nil nil nil t)

(quail-define-rules

;;Lowercase

;;1st layer top row

 ("^" ?^)
 ("1" ?1)
 ("2" ?2)
 ("3" ?3)
 ("4" ?4)
 ("5" ?5)
 ("6" ?6)
 ("7" ?7)
 ("8" ?8)
 ("9" ?9)
 ("0" ?0)
 ("ß" ?ß)
 ("´" ?´)

 ;;1st layer second row
 ("q" ?k)
 ("w" ?w)
 ("e" ?e)
 ("r" ?r)
 ("t" ?t)
 ("z" ?z)
 ("u" ?u)
 ("i" ?i)
 ("o" ?o)
 ("p" ?p)
 ("ü" ?ü)
 ("+" ?+)

 ;;1st layer third row
 ("a" ?a)
 ("s" ?s)
 ("d" ?d)
 ("f" ?f)
 ("g" ?g)
 ("h" ?h)
 ("j" ?j)
 ("k" ?k)
 ("l" ?l)
 ("ö" ?ö)
 ("ä" ?ä)
 ;;("#" ?nil)

 ;;1st layer forth row
 ;;("<" ?nil)
 ("y" ?y)
 ("x" ?x)
 ("c" ?c)
 ("v" ?v)
 ("b" ?b)
 ("n" ?n)
 ("m" ?m)
 ("," ?,)
 ("." ?.)
 ("-" ?-)

 ;;uuuuuuuuuuuupercase

 ;;1st layer top row

  ("\°" ?\°)
  ("\!" ?\!)
  ("\"" ?\")
  ("\§" ?\§)
  ("\$" ?\$)
  ("\%" ?\%)
  ("\&" ?\&)
  ("\/" ?\/)
  ("\(" ?\()
  ("\)" ?\))
  ("\=" ?\=)
  ("\?" ?\?)
  ("\`" ?\`)

  ;;1st layer second row
  ("Q" ?Q)
  ("W" ?W)
  ("E" ?E)
  ("R" ?R)
  ("T" ?T)
  ("Z" ?Z)
  ("U" ?U)
  ("I" ?I)
  ("O" ?O)
  ("P" ?P)
  ("Ü" ?Ü)


  ;;1st layer third row
  ("A" ?A)
  ("S" ?S)
  ("D" ?D)
  ("F" ?F)
  ("G" ?G)
  ("H" ?H)
  ("J" ?J)
  ("K" ?K)
  ("L" ?N)
  ("Ö" ?Ö)
  ("Ä" ?Ä)
  ;;("#" ?nil)

  ;;1st layer forth row
  ;;("<" ?nil)
  ("Y" ?Y)
  ("X" ?X)
  ("C" ?C)
  ("V" ?V)
  ("B" ?B)
  ("N" ?N)
  ("M" ?M)

 )
(provide 'normal-input)
