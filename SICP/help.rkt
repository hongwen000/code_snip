#lang sicp
(define (average x y) (/ (+ x y) 2))
(define (average-damp f)
  (lambda (x) (average x (f x))))
(define (avged-cubic a b c)
  (average-damp (cubic a b c)))
(define (cubic a b c)
  (lambda (x)
    (+ (cube x)
       (* a (square x))
       (* b x)
       c
    )
  )
)
(define (compose f g)
  (lambda (x) (f (g x))))

(define (repeated f n)
  (define (repeated-helper f n k h)
    (if (= n k)
      h
      (repeated-helper f n (+ 1 k) (compose f h))))
  (repeated-helper f n 1 f))
(define (square x) (* x x))
(define tolerance 0.00000001)
(define (fixed-point f first-guess)
  (define (close-enough? v1 v2)
    (< (abs (- v1 v2)) tolerance))
  (define (try guess)
    (let ((next (f guess)))
      (if (close-enough? guess next)
        next
        (try next))))
  (try first-guess))
(define (deriv g)
  (lambda (x)
    (/ (- (g (+ x dx)) (g x))
       dx)))
(define dx 0.00001)
(define (cube x) (* x x x))
(define (newton-transform g)
  (lambda (x)
    (- x (/ (g x)
            ((deriv g) x)
         )
    )
  )
)
(define (newton-method g guess)
  (fixed-point (newton-transform g) guess))
(define (my-sqrt x)
  (newton-method (lambda (y) (- (square y) x))
                 1.0))
(define (try avg-times real-power y)
  (let ((power (- real-power 1)))
    (fixed-point ((repeated average-damp avg-times)
                       (lambda (x) (/ y
                                      (expt x power)))
                       )
             1.0
             )
  )
)
; power     1 2 3 4 5 6 7 8
; avg-times 0 1 1 2 2 2 2 3
; 2^        0 1 1 2 2 2 2 3
; log n / log 2 向下取整
(define (log-two-down real-power)
    (if (or (> real-power 2) (= real-power 2))
      (+ 1
         (log-two-down (/ real-power 2)))
    0))
(define (nth-sqrt real-power y)
  (try (log-two-down real-power) real-power y))

(define (term2-k2 T-v1-k2)
  (let ((tmp (square (/ T-v1-k2 300))))
    (/ 1.0 (* tmp (nth-sqrt 5 tmp)))))

(define c1-k2 6E-34)

(define (calc-k2 T-v1-k2)
  (* c1-k2 (term2-k2 T-v1-k2)))

(define (big xN xD aN aD)
  (newton-method (lambda (y) (- (* (expt y aD)
                                   (expt xD aN))
                                (expt xN aN)))
                 1.0))