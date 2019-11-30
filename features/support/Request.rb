class Request

    def request(method, url, payload=nil, headers=nil)

        p url

        p "puts"

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
            puts "hold on, hanase"
        end

        p "Terminou"

        return res
    
    end


end