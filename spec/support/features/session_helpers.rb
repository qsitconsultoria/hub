module Features
  module SessionHelpers
    PASSWORD = '123123123'

    def create_admin_user
      Admin.find_or_create_by!( email: 'admin@example.com') do |user|
        user.name = 'Admin User'
        user.password = PASSWORD
      end
    end

    def create_manager
      manager = Manager.invite!(email: 'manager@example.com', name: 'Manager') do |u|
        u.skip_invitation = true
      end

      Manager.accept_invitation!(:invitation_token => manager.instance_variable_get(:@raw_invitation_token),
                                 :password => PASSWORD,
                                 :password_confirmation => PASSWORD)

      manager
    end

    def create_teacher
      Teacher.find_or_create_by!(email: 'teacher@example.com') do |user|
        user.name = 'Teacher'
        user.password = PASSWORD
      end
    end

    def create_student
      Student.find_or_create_by!(email: 'student@example.com') do |user|
        user.name = 'Student'
        user.password = PASSWORD
        user.works_on = 'ONG'
        user.scholarity_level = 'Mestrado'
        user.field_of_operation = 'Direito'
      end
    end

    def sign_in_user(user)
      visit '/admin'

      fill_in 'user[email]', with: user.email
      fill_in 'user[password]', with: PASSWORD

      click_button 'Entrar'

      expect(page).to have_content 'Sair'
    end
  end
end
