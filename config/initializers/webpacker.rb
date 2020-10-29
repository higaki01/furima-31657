Webpacker::Compiler.env["PAYJP_PUBLIC_KEY"] = ENV["PAYJP_PUBLIC_KEY"]
Webpacker::Compiler.env["PAYJP_PUBLIC_KEY"] = <%= Rails.application.credentials.dig(:payjp, :payjp_public_key) %>