
@student_classes = nil
@student_class_id = nil
@student_users = nil

    #Lista as salas

Quando("listar as salas") do

    @student_classes = StudentClass.new.getStudentClassList
   
end

    #Valida se todas as salas possuem matéria

Então("todas precisam ter pelo menos uma matéria") do

    StudentClass.new.validateAllHaveSubject(@student_classes)
    
end

    #Puxar as salas pelo ID

Quando("puxar cada sala pelo seu id") do

    @student_class_id = StudentClass.new.classIdPullByList(@student_classes)

end
 
    #Validar se as salas pertencem ao mesmo ID

Então("As salas por id não terão diferença das da listagem") do

    @student_classes["content"].sort! {|a,b| a["_id"] <=> b["_id"]}
    Utils.new.compare(@student_classes["content"], @student_class_id)

end
   
    #Valida se o professor pertencem a alguma materia

Então("todas as materias precisam ter professores validos") do

    User.new.validateTeacher(@student_classes)

end
  
    #Executa Login

Quando("realiza um login como {string}") do |user_type|

    @login_response, @login_payload = User.new.executeLogin(user_type)

end
  
    #Verifica se o login é valido

Entao("deve retornar as informações do usuario") do

    Utils.new.compare(@login_response["email"], @login_payload["email"] )
    raise "Usuário não encontrado" if !@login_response 

end
  
    #Validar se todos professores estão na matéria certa

Então("todas a materias tem seus recpectivos professores") do
    
    User.new.validateTeacherSubject(@student_classes)

end
  
Quando("listar os alunos") do

    @student_users = User.new.getUserWaves(100)

end
  
Então("verificar as matérias que o aluno possui") do
    # binding.pry
        User.new.validateStudentSubject(@student_users)

end
    