
@studentClasses = nil
@studentClassId = nil


Quando("listar as salas") do

    @studentClasses = Utils.new.req("get", "studentClass", "list?pageSize=900")
   
end

Então("todas precisam ter pelo menos uma matéria") do

    StudentClass.new.validate_all_have_subject(@studentClasses)
    
end

Quando("puxar cada sala pelo seu id") do

    @studentClassId = StudentClass.new.class_id_pull_by_list(@studentClasses)

end
 
Então("As salas por id não terão diferença das da listagem") do

    Utils.new.compare(@studentClasses["content"], @studentClassId)

end
  
  
Então("todas as materias precisam ter professores validos") do
    # binding.pry
    User.new.validateTeacher(@studentClasses)

end
  
Quando("realiza um login como {string}") do |userType|

    @login_response = User.new.executeLogin(userType)

    # binding.pry

end
  
  
Entao("deve retornar as informações do usuario") do

    raise "Usuário não encontrado" if !@login_response 
        
end
  