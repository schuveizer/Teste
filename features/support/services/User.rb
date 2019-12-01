class User

    def validateTeacher(studentClasses)

        threads = []

        studentClasses["content"].each do |studentClass|

            studentClass["schoolSubjects"].each do |schoolSubject|

                # binding.pry
            threads.push(
            
                Thread.new do 

                    teacherId = schoolSubject["theme"]["teacherId"]

                    teacher = Utils.new.req("get", "user", teacherId)

                    Utils.new.compare(teacher["userType"], "teacher")

                 end) 

            end


        end

        threads.each(&:join)

    end

    def executeLogin(user_type)

        login = PAY["login_#{user_type}"]
binding.pry 
        return Utils.new.req("POST", "user", "login", login)

    end

end