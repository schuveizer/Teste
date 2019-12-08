class User

    def getUserList(page_size = 9999, page_number = 0)
                     
        Utils.new.req("get", "user", "list?pageSize=#{page_size}&page+number=#{page_number}")["content"]
        
    end

    def getUserWaves(page_size)
        
        count = 0 

        current_user_list = nil

        full_user_list = []

        while current_user_list != [] do

            current_user_list = getUserList(page_size, count)
            
            count += 1

            full_user_list.push(current_user_list)

        end
        
        return full_user_list.flatten

    end

    def validateTeacher(student_classes)

        threads = []

        student_classes.each do |student_class|

            student_class["schoolSubjects"].each do |school_subject|

                # binding.pry
            threads.push(
            
                Thread.new do 

                    teacher_id = school_subject["theme"]["teacherId"]

                    teacher = Utils.new.req("get", "user", teacher_id)

                    Utils.new.compare(teacher["userType"], "teacher")

                 end) 

            end


        end

        threads.each(&:join)

    end

    def executeLogin(user_type)

        login = PAY["login_#{user_type}"]
# binding.pry 
        return Utils.new.req("POST", "user", "login", login), login

    end

    def validateTeacherSubject(student_classes)

        threads = []

        student_classes.each do |student_class|

            student_class["schoolSubjects"].each do |school_subject|

                threads.push(
            
                Thread.new do 
                    
                        teacher_id = school_subject["theme"]["teacherId"]

                        teacher = Utils.new.req("get", "user", teacher_id)

                        teacher_theme_schedule = nil

                        teacher["schedules"].each do |schedule|

                            if schedule["themeId"] == school_subject["theme"]["_id"]

                                teacher_theme_schedule = schedule

                                break
                                
                            end
                        
                        end

                        if !teacher_theme_schedule

                            raise "Nenhuma materia associada ao professor"

                        else

                            p "Good job"
                            
                        end
                
                end)

            end

        end
        
        threads.each(&:join)
        # binding.pry

    end

    def checkSubjectThemeId(student_class_list, theme_id)
        
        select_subject = nil

        student_class_list.each do |student_class|

            student_class["schoolSubjects"].each do |school_subject|

                if school_subject["theme"]["_id"] == theme_id 

                    select_subject = school_subject

                    break
                    
                end

            end    
            
        end

        return select_subject

    end

    def validateStudentSubject(user_list)

        student_class_list = StudentClass.new.getStudentClassList

        student_list = []

        user_list.each do |user|
            
            p user["userType"]

            if user["userType"] == "student"

                student_list.push(user)
                
            end

        end

        # binding.pry
        
        student_list.each do |student|
        
            student_theme_schedule = nil

            student["schedules"].each do |schedule|
            
                # binding.pry
                if !checkSubjectThemeId(student_class_list, schedule["themeId"])
                     
                    raise "Nenhuma materia associada ao aluno"

                else
    
                    p "Good job"

                end
            
            end    

        end

    end

end
