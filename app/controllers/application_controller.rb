class ApplicationController < ActionController::API
	def new_token(id)
		self.encode_token({id: id})
	end

	def encode_token(payload)
		JWT.encode(payload, self.secret)
	end

	def auth_header
		request.headers['Authorization']
	end

	def decoded_token
		if self.auth_header
			token = self.auth_header.split(' ')[1]
			begin
				JWT.decode(token, self.secret)[0]
			rescue JWT::DecodeError
				nil
			end
		end
	end

	def secret
		"crap"
	end
end
