module Response
    def json_response(object, status = :ok)
        render json: { status: true , data: object }, status: status
    end 
end 