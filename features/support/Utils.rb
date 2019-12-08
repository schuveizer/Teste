class Utils

    def request(method, url, payload=nil)

        headers = HEAD["standard"]

        p url

        # p "puts"

        payload = payload.to_json if payload

        res = nil
        req = nil
        cod = nil

        RestClient::Request.execute(method: method, url: url, payload: payload, headers: headers, timeout: 30) do |resposta, pedido, codigo|

            res = resposta

            req = pedido

            cod = codigo

        end
    
        begin
            res = JSON.parse(res)
        rescue
            puts "There was a problem with request"
        end

        p "Terminou"

        return res
    
    end

    def compare(el1, el2)

        if el1. == el2
            p "Sucesso"
        else
            raise "Failure, #{el1} is diferent than #{el2}"
        end

    end

    def req(method, type, path =nil, payload =nil)

        url = "https://presencelist.herokuapp.com/#{type}/#{path}"
        return request(method, url, payload)

    end
end

