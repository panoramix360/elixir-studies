fizzbuzz = fn
  0, 0, _ -> "FizzBuzz."
  0, _, _ -> "Fizz."
  _, 0, _ -> "Buzz."
  _, _, c -> c
end

fizzbuzz_wrap = fn n ->
  fizzbuzz.(rem(n, 3), rem(n, 5), n)
end

IO.puts fizzbuzz_wrap.(10)

IO.puts fizzbuzz_wrap.(11)

IO.puts fizzbuzz_wrap.(12)

IO.puts fizzbuzz_wrap.(13)

IO.puts fizzbuzz_wrap.(14)

IO.puts fizzbuzz_wrap.(15)

IO.puts fizzbuzz_wrap.(16)
