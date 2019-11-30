@values = 0
@result

@invalid_login_payload
@headers


Dado("que puts") do
    p "puts"
end
  
Quando("pegar {int}") do |num|
    @values = num

end

Quando("somar com {int}") do |num|
    @result = Utils.new.sum(@values, num)
end

Então("tenho {int}") do |expected_result|
    raise "Dafuk dude #{@result} nem é #{expected_result} tá fumando?" if @result != expected_result
end
  

Quando("bater no endpoint {string}") do |url|
    Request.new.request("get", url)
end
  
Então("devo estar no site da google") do
    p "sucesso"
end

Quando("preencher meu payload de login invalido") do
 p "hue"

end
  
Quando("executar login") do
    binding.pry
    threads = []

    (0...100).each do
        threads.push( Thread.new{
        Request.new.request("get", "https://presencelist.herokuapp.com/user/list")
        })
    end

    threads.each(&:join)

end

Então("Então devo receber uma resposta {int} erro") do |int|
    pending # Write code here that turns the phrase above into concrete actions
end
  
 