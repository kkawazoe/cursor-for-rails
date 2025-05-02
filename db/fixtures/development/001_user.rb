require 'faker'

(1..5).each do |n|
  User.seed(
    :id,
    {
      id: n,
      email: "#{format('user%03<number>d', number: n)}@example.co.jp",
      password: 'password',
      password_confirmation: 'password'
    }
  )
end
