# This class is used for logins
class Login
  attr_reader :sessions, :users, :passwords

  # Receives a hash with usernames as keys and passwords as values
  def initialize(hash)
    @sessions = []
    @users = []
    @passwords = []
    hash.map do |k,v|
      @users = @users + [k]
      @passwords = @passwords + [v]
    end
  end

  def logout(user)
    sessions.delete(user)
  end

  # Checks if user exists
  def user_exists(user)
    @users.include?(user)
  end

  # Register user
  def register_user(user, password)
    @users << user
    @passwords << password
  end

  def remove_user(user)
    index = idx(user)
    @users.delete user
    @passwords.delete passwords[index]
  end

  def check_password(user, password)
    index = idx(user)
    passwords[index] == password
  end

  def update_password(user, old_password, new_password)
    # First we check if the user exists
    if idx(user)
      index = idx(user)
       passwords[index] = new_password and return true if passwords[index] == old_password
    end
    return false
  end

  def login(user, password)
    index = idx(user)
    sessions << user if passwords[index] == password
  end

  # Gets index of an element in an array
  def idx(element, array)
    array.index(element)
  end

end



registered_users = {
  'user1' => 'pass1',
  'user2' => 'pass2',
  'user3' => 'pass3'
}

login = Login.new(registered_users)

login.register_user('user4', 'pass4');
login.login('user4', 'pass4');
login.update_password('user3', 'pass3', 'pass5');
login.login('user3', 'pass5');
login.logout('user4');
login.logout('user3');