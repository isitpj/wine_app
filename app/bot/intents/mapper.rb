module Intents
  class Mapper
    def self.map_intent_to_message(intent, facebook_id: nil)
      case intent
      when :create_account
        create_account_message
      when :CREATE_ACCOUNT
        handle_create_account_confirmation(facebook_id)
      when :add_red
        add_red_message
      when :add_white
        add_white_message
      else
        fallback_message
      end
    end

    class << self
      private def create_account_message
        {
          message: {
            text: 'Would you like to create your account with Charles d\'Née?',
            quick_replies: account_creation_quick_replies
          }
        }
      end

      private def handle_create_account_confirmation(facebook_id)
        data = Users::RetrieveUserData.call(facebook_id)
        Users::FindOrCreateUser.call(user_data: data)
        {
          message: {
            text: 'Great! You have successfully created an account with Charles d\'Née.',
          }
        }
      end

      private def add_red_message
        {
          message: {
            text: 'How lovely! Would you like to add a new bottle of red to your cellar?',
          }
        }
      end

      private def add_white_message
        {
          message: {
            text: 'How lovely! Would you like to add a new bottle of white to your cellar?',
          }
        }
      end

      private def fallback_message
        {
          message: {
            text: 'I\'m sorry, I don\'t understand that yet',
          }
        }
      end

      private def account_creation_quick_replies
        [
          {
            content_type: 'text',
            title: 'Yes please!',
            payload: 'CREATE_ACCOUNT'
          },
          {
            content_type: 'text',
            title: 'Not right now',
            payload: 'NULL'
          }
        ]
      end
    end
  end
end
