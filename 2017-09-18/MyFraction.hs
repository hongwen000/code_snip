module MyFraction where
import Test.QuickCheck

{- 李新锐 15323032，453821056@qq.com，16级计算机类
 - 对实现的分数运算进行了以下性质的测试
 - 加法交换律                    prop_ratplus_commutativity
 - 加法结合律                    prop_ratplus_associativity
 - 加法中任意数加0等于自身的性质 prop_ratplus_unit
 - 减法作为加法逆运算的性质      prop_ratminus_reverse
 - 减法的逆交换律                prop_ratminus_anticommutativity
 - 乘法交换律                    prop_rattimes_commutativity
 - 乘法对加法的分配率            prop_rattimes_plus_distr
 - 乘法结合律                    prop_rattimes_associativity
 - 乘法中任意数乘1等于自身的性质 prop_rattimes_unit
 - 除法作为乘法逆运算的性质      prop_ratdiv_reverse
 - 除法的逆交换律                prop_ratdiv_anticommutativity
 - 在MacOS 10.12，GHC 8.02下测试结果如下,均通过
 - *MyFraction>     quickCheck prop_ratplus_commutativity
 - +++ OK, passed 100 tests.
 - *MyFraction>     quickCheck prop_ratplus_associativity
 - +++ OK, passed 100 tests.
 - *MyFraction>     quickCheck prop_ratplus_unit
 - +++ OK, passed 100 tests.
 - *MyFraction>     quickCheck prop_ratminus_reverse
 - +++ OK, passed 100 tests.
 - *MyFraction>     quickCheck prop_ratminus_anticommutativity
 - +++ OK, passed 100 tests.
 - *MyFraction>     quickCheck prop_rattimes_commutativity
 - +++ OK, passed 100 tests.
 - *MyFraction>     quickCheck prop_rattimes_plus_distr
 - +++ OK, passed 100 tests.
 - *MyFraction>     quickCheck prop_rattimes_associativity
 - +++ OK, passed 100 tests.
 - *MyFraction>     quickCheck prop_rattimes_unit
 - +++ OK, passed 100 tests.
 - *MyFraction>     quickCheck prop_ratdiv_reverse
 - +++ OK, passed 100 tests.
 - *MyFraction>     quickCheck prop_ratdiv_anticommutativity
 - +++ OK, passed 100 tests.
 - -}

myGCD :: Integer -> Integer -> Integer
myGCD a 0 = a
myGCD a b = myGCD b (a `mod` b)

type Fraction = (Integer, Integer)

toPositive :: Integer -> Integer
toPositive a
  |a > 0 = a
  |otherwise = -a

adjustsign :: Fraction -> Fraction
adjustsign (a, b)
  |(a > 0) == (b > 0) = (a, b)
  |otherwise = (- toPositive a, toPositive b)

simpilfy :: Fraction -> Fraction
simpilfy (a, b) = adjustsign (a `div` c, b `div` c)
  where c = myGCD a b

ratplus :: Fraction -> Fraction -> Fraction
ratplus (a, b) (c, d) = simpilfy (a * d + c * b, b * d)

ratminus :: Fraction -> Fraction -> Fraction
ratminus (a, b) (c, d) = simpilfy (a * d - c * b, b * d)

rattimes :: Fraction -> Fraction -> Fraction
rattimes (a, b) (c, d) = simpilfy (a * c, b * d)

ratdiv :: Fraction -> Fraction -> Fraction
ratdiv (a, b) (c, d) = rattimes (a, b) (d, c)

ratfloor :: Fraction -> Integer
ratfloor (a, b) = a `div` b

ratfloat :: Fraction -> Float
ratfloat (a, b) = fromInteger a / fromInteger b

rateq :: Fraction -> Fraction -> Bool
rateq (a, b) (c, d) = a * d == b * c

infix 5 <+>
(<+>) :: Fraction -> Fraction -> Fraction
(<+>) (a,b) (c,d) = ratplus (a,b) (c,d)

infix 5 <->
(<->) :: Fraction -> Fraction -> Fraction
(<->) (a,b) (c,d) = ratminus (a,b) (c,d)

infix 6 <-*->
(<-*->) :: Fraction -> Fraction -> Fraction
(<-*->) (a,b) (c,d) = rattimes (a,b) (c,d)

infix 6 </>
(</>) :: Fraction -> Fraction -> Fraction
(</>) (a,b) (c,d) = ratdiv (a,b) (c,d)

infix 4 <==>
(<==>) :: Fraction -> Fraction -> Bool
(<==>) = rateq

prop_ratplus_commutativity :: Fraction -> Fraction -> Property
prop_ratplus_commutativity (a, b) (c, d) = b /= 0 && d /= 0 ==> (a, b) <+> (c, d) <==> (c, d) <+> (a, b)

prop_ratplus_associativity :: Fraction -> Fraction -> Fraction -> Property
prop_ratplus_associativity (a, b) (c, d) (e, f) = b /= 0 && d /= 0 && f /= 0 ==> ((a, b) <+> (c, d)) <+> (e, f) <==> (a, b) <+> ((c, d) <+> (e, f))

prop_ratplus_unit :: Fraction -> Property
prop_ratplus_unit (a,b) = b /= 0 ==> (a, b) <+> (0,1) <==> simpilfy(a, b)

prop_ratminus_reverse :: Fraction -> Fraction -> Property
prop_ratminus_reverse (a, b) (c, d) = b /= 0 && d /= 0 ==> ((a, b) <+> (c, d)) <-> (c, d) <==> (a, b)

prop_ratminus_anticommutativity :: Fraction -> Fraction -> Property
prop_ratminus_anticommutativity (a, b) (c, d) = b /= 0 && d /= 0 ==> (a, b) <-> (c, d) <==> (0, 1) <-> ((c, d) <-> (a, b))


prop_rattimes_commutativity :: Fraction -> Fraction -> Property
prop_rattimes_commutativity (a, b) (c, d) = b /= 0 && d /= 0 ==> (a, b) <-*-> (c, d) <==> (c, d) <-*-> (a, b)

prop_rattimes_associativity :: Fraction -> Fraction -> Fraction -> Property
prop_rattimes_associativity (a, b) (c, d) (e, f) = b /= 0 && d /= 0 && f /= 0 ==> ((a, b) <-*-> (c, d)) <-*-> (e, f) <==> (a, b) <-*-> ((c, d) <-*-> (e, f))

prop_rattimes_unit :: Fraction -> Property
prop_rattimes_unit (a,b) = b /= 0 ==> (a, b) <-*-> (0,1) <==> (0,1)

prop_rattimes_plus_distr :: Fraction -> Fraction -> Fraction ->Property
prop_rattimes_plus_distr (a,b) (c,d) (e,f) = b /= 0 && d /= 0 && f /= 0 ==> (a,b) <-*-> ((c,d) <+> (e,f)) <==> ((a,b) <-*-> (c,d)) <+> ((a,b) <-*-> (e,f))

prop_ratdiv_reverse :: Fraction -> Fraction -> Property
prop_ratdiv_reverse (a, b) (c, d) = b /= 0 && c /= 0 && d /= 0 ==> ((a, b) <-*-> (c, d)) </> (c, d) <==> (a, b)

prop_ratdiv_anticommutativity :: Fraction -> Fraction -> Property
prop_ratdiv_anticommutativity (a, b) (c, d) = a /= 0 && b /= 0 && c /= 0 && d /= 0 ==> (a, b) </> (c, d) <==> (1, 1) </> ((c, d) </> (a, b))
