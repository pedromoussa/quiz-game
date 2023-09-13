ActiveAdmin.register User do

  permit_params :username, :password, :password_confirmation

  form title: "Novo Jogador" do |f|
    f.inputs do
      f.input :username
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end

end
