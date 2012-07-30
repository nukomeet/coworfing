# Core ruby extensions

String.class_eval do
  # helper that generates a random alphanumeric string
  def self.random_alphanum(size = 6)
    chars = ('a'..'z').to_a + ('A'..'Z').to_a + ('0'..'9').to_a
    (0...size).collect { chars[Kernel.rand(chars.length)] }.join
  end
end
