#lang racket

(define-values (in out)
  (tcp-connect "172.30.73.216" 1228))
  ;(values (current-input-port)
  ;        (current-output-port)))

(define (be->int bt)
  (integer-bytes->integer bt #f #t))
(define (int->le int)
  (integer->integer-bytes int 4 #f #f))

(for ([i 5])
  (displayln (read-line in)))

(let* ([a (read-bytes 4 in)]
       [b (read-bytes 4 in)]
       [a* (be->int a)]
       [b* (be->int b)]
       [sum (+ a* b*)]
       [mod-sum (modulo sum (expt 2 32))]
       [le (int->le sum)])
  (displayln (list a b a* b* sum mod-sum le))
  (display le out)
  (flush-output out))

(for ([i 100])
  (display (read-bytes 4 in)))