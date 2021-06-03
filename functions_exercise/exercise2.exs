fizzbuzz = fn
  0, 0, _ -> "FizzBuzz."
  0, _, _ -> "Fizz."
  _, 0, _ -> "Buzz."
  _, _, c -> c
end

IO.puts fizzbuzz.(0, 0, 2)

IO.puts fizzbuzz.(0, 3, 2)

IO.puts fizzbuzz.(3, 0, 2)

IO.puts fizzbuzz.(4, 3, 2)
