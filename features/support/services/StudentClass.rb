class StudentClass

    def validate_all_have_subject(studentClasses)

        studentClasses["content"].each do |studentClass|

            if studentClass["schoolSubjects"][0]

                studentClass["schoolSubjects"].each do |schoolSubject|

                    p "#{studentClass["name"]} -> #{schoolSubject["name"]}}"

                end

            else

                raise "hell"

            end

        end

    end

    def class_id_pull_by_list(studentClasses)

        # return push each

        # threads = []

        studentClassesId = []

        studentClasses["content"].each do |studentClass|
            
            # threads.push(Thread.new do 

                studentClassId = Utils.new.req("get", "studentClass", studentClass["_id"])

                studentClassesId.push(studentClassId)
                
            # end)
           
        end
        
        # threads.each(&:join)

        return studentClassesId

            

    end


end