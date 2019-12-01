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
       
    utils = Utils.new
    response = utils.req("get", "studentClass", "list?pageSize=900")

    # binding.pry

    # response = utils.request("get", "https://presencelist.herokuapp.com/studentClass/list?pageSize=900")
    
    p response["content"].count
    
    studentClass = response["content"].sample

    p studentClass["name"]

    schoolSubject = studentClass["schoolSubjects"].sample

    p schoolSubject["name"]

    #Uma sala aleatória com uma matéria aleatoria desta sala ^^^^^^

    studentClassId = studentClass["_id"]

    responseID = utils.req("get", "studentClass", studentClassId)

    # url = "https://presencelist.herokuapp.com/studentClass/#{studentClassId}"

    # responseID = utils.request("get", url)

    #Puxar ID especifico ^^^^^^

    utils.compare(responseID, studentClass)
    # if responseID == studentClass 
    #     p "Aeeeeee"
    # else
    #     p "nuuuuuu"
    
    # end

    #Testar se é o mesmo Id ^^^^^^

    teacherId = schoolSubject["theme"]["teacherId"]

    teacher = utils.req("get", "user", teacherId)

    # url = "https://presencelist.herokuapp.com/user/#{teacherId}"

    # teacher = utils.request("get", url)

    p teacher["name"]

    utils.compare(teacher["userType"], "teacher")
    # if teacher["userType"] == "teacher"
    #     p "Senpai"
    # else
    #     p "not senpai"
    # end


    #Puxando e verificando se é senpai ^^^^^^

    teacherThemeId = teacher["schedules"].sample["themeId"]

    themeId = schoolSubject["theme"]["_id"]

    utils.compare(teacherThemeId, themeId)
    # if teacherThemeId == themeId
    #     p "Não Merda"
    # else
    #     p "Merda"
    # end

    #Puxando e verificando se esse professor é da sala ^^^^^^

    # binding.pry  

    studentId = schoolSubject["theme"]["userIds"].sample

    student = utils.req("get", "user", studentId)

    # binding.pry

    # url = "https://presencelist.herokuapp.com/user/#{studentId}"

    # student = Request.new.request("get", url)

    utils.compare(student["userType"], "student")
    # if student["userType"] == "student"
    #     p "Aluno"
    # else
    #     p "Não aluno"
    # end
    

# binding.pry

    user_to_create = PAY["user"].clone
    
    login_email = "beto@beto.carrero.world"
    login_password = "Iha"

    user_to_create["email"] = login_email
    user_to_create["password"] = login_password
    user_to_create["name"] = "Bitu"

    created_user = utils.req("POST", "user", nil, user_to_create)

# binding.pry 

    login = PAY["login"].clone

    login["email"] = login_email
    login["password"] = login_password

    login_user = utils.req("POST", "user", "login", login)

    utils.req("delete", "user", created_user["_id"])

# ///////////////////////////////////////////////////////////////////

    user_to_create = PAY["user"].clone
    
    student_email = "beta@beta."
    student_password = "Iho"

    user_to_create["email"] = student_email
    user_to_create["password"] = student_password
    user_to_create["name"] = "Beta"

    created_student = utils.req("POST", "user", nil, user_to_create)

# ///////////////////////////////////////////////////////////////////

    user_to_create = PAY["user"].clone
    
    teacher_email = "beto@beto"
    teacher_password = "Iha"

    user_to_create["email"] = teacher_email
    user_to_create["password"] = teacher_password
    user_to_create["name"] = "Beto"

    created_teacher = utils.req("POST", "user", nil, user_to_create)


    theme = PAY["theme"].clone
    theme["userIds"].push(created_student["_id"])
    theme["teacherId"] = created_teacher["_id"]
    theme["schedules"].push("wednesday 15:30")

    subject = PAY["schoolSubjects"].clone
    subject["theme"] = theme
    stdclass = PAY["studentClass"].clone
    stdclass["schoolSubjects"].push(subject)

    created_class = utils.req("POST", "studentClass", nil, stdclass)

    utils.req("delete", "studentClass", created_class["_id"])
    utils.req("delete", "user", created_student["_id"])
    utils.req("delete", "user", created_teacher["_id"])

    binding.pry

end

Então("Então devo receber uma resposta {int} erro") do |int|

end