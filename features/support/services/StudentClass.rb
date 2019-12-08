class StudentClass

        #Pegar a listagem das salas

    def getStudentClassList(page_size = 9999, page_number = 0)
    
        Utils.new.req("get", "studentClass", "list?pageSize#{page_size}&page+number=#{page_number}")["content"]

    end

        #Valida se todas as salas possuem matéria

    def validateAllHaveSubject(student_classes)

        student_classes["content"].each do |student_class|

            if student_class["schoolSubjects"][0]

                student_class["schoolSubjects"].each do |school_subject|

                    p "#{student_class["name"]} -> #{school_subject["name"]}}"

                end

            else

                raise "hell"

            end

        end

    end

        #Puxar os ids das salas por thread e armazenar numa variavel ordenada
   
    def classIdPullByList(student_classes)

        # return push each thread

        threads = []

        student_classes_id = []

        student_classes["content"].each do |student_class|
            
            threads.push(Thread.new do 

                student_class_id = Utils.new.req("get", "studentClass", student_class["_id"])

                student_classes_id.push(student_class_id)
                
            end)

        end
        
        threads.each(&:join)

        student_classes_id.sort! {|a , b|  a["_id"] <=> b["_id"]}

        return student_classes_id

    end


end