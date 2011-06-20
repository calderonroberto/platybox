require 'oauth'
require 'uri'
require 'net/http'

module Platybox
  class Client
      
      attr_accessor :consumer_key, :consumer_secret
      
      def initialize(consumer_key, consumer_secret)
        @site = "http://api.platybox.com"
        @consumer_key = consumer_key
        @consumer_secret = consumer_secret
      end
  
      def prepare_access_token(oauth_token, oauth_secret)
        consumer = OAuth::Consumer.new( @consumer_key, @consumer_secret, 
          { :site => @site,
            :authorize_path => "authorize",
            :access_token_path => "access_token",
            :request_token_path=>"request_token"})
            
        token_hash ={ :oauth_token => oauth_token,
            :oauth_token_secret => oauth_secret}          
        access_token = OAuth::AccessToken.from_hash(consumer, token_hash)        
        return access_token
      end

      # returns the current user
      # @return [Hash] The requested user
      def users_show (current_user, id)
        @access_token = prepare_access_token(current_user.token, current_user.secret)
        if id.nil?
          @response = @access_token.request(:get, @site + "/1/users/show")
        else
          @response = @access_token.request(:post, @site + "/1/users/show", :id => id)
        end
        @user = JSON.parse(@response.body())["user"]  
      end
  
      #returns the selected bit
      #@param id [Integer] The numeric ID representing the bit.
      #@return [Hash] The requested bit
      def bits_show (current_user, id)
        @access_token = prepare_access_token(current_user.token, current_user.secret)
        @response = @access_token.request(:post, @site + "/1/bits/show", :id => id)
        @bit = JSON.parse(@response.body())["bit"]  
      end
      
      #returns the selected place
      #@param id [Integer] The numeric ID representing the place.
      def places_show (current_user, id)
        @access_token = prepare_access_token(current_user.token, current_user.secret)
        @response = @access_token.request(:post, @site + "/1/places/show", :id => id)
        @place = JSON.parse(@response.body())  
      end
      
      #returns an array of sponsored promos, need not be authenticated
      def promos_sponsored
        url = URI.parse( @site + "/1/promos/sponsored")
        req = Net::HTTP::Get.new(url.path)
        @response = Net::HTTP.start(url.host, url.port) {|http|
          http.request(req)
        }
        @promos = JSON.parse(@response.body())["promos"]        
      end
            
      #returns an array of promos of a place
      #@param places_id [Integer] The numeric ID that identifies a place
      #@return [Array][Hash][Hash] An array of promo objects
      def promos_place (current_user, id)
        @access_token = prepare_access_token(current_user.token, current_user.secret)
        @response = @access_token.request(:post, @site + "/1/promos/place", :id => id)
        @promos = JSON.parse(@response.body())["promos"]
      end
        
      #Consumes a promo
      #@param id [Integer] The numeric ID that identifies the promo
      #@return [Hash][Hash] the promo object
      def promos_consume (current_user, id)
        @access_token = prepare_access_token(current_user.token, current_user.secret)
        @response = @access_token.request(:post, @site + "/1/promos/consume", :id => id)
        @promo = JSON.parse(@response.body())
      end
    
      #Checks in
      #@param id [Integer] The numeric ID that identifies the bit
      #@return [Hash][Hash] a checkin object and a user object
      def checkins_bit(current_user, id)
        @access_token = prepare_access_token(current_user.token, current_user.secret)
        @response = @access_token.request(:post, @site + "/1/checkins/bit", :id => id)
        @checkin = JSON.parse(@response.body())  
      end
      
      #Leaders Promos
      #@return [Array][Hash][Hash] a leaders array containing user objects
      def leaders_promos(current_user, id)
        @access_token = prepare_access_token(current_user.token, current_user.secret)
        @response = @access_token.request(:post, @site + "/1/leaders/promos")
        @leaders = JSON.parse(@response.body())["leaders"]
      end
      
      #Leaders Quests
      #@return [Array][Hash][Hash] a leaders array containing user objects
      def leaders_quests(current_user, id)
        @access_token = prepare_access_token(current_user.token, current_user.secret)
        @response = @access_token.request(:post, @site + "/1/leaders/quests")
        @leaders = JSON.parse(@response.body())["leaders"]
      end   
      
      #show promo by bit id
      def promos_show_by_bit(current_user, bits_id)
        @access_token = prepare_access_token(current_user.token, current_user.secret)
        @response = @access_token.request(:post, @site + "/1/promos/show", :bits_id => bits_id)
        @promo = JSON.parse(@response.body())
      end
      
      #show promo by id
      def promos_show(current_user, id)
        @access_token = prepare_access_token(current_user.token, current_user.secret)
        @response = @access_token.request(:post, @site + "/1/promos/show", :id => id)
        @promo = JSON.parse(@response.body())
      end
           
      #invalidate promo
      def promos_invalidate(current_user, id)
        @access_token = prepare_access_token(current_user.token, current_user.secret)
        @response = @access_token.request(:post, @site + "/1/promos/invalidate", :id => id)
        @promo = JSON.parse(@response.body())
      end
      
      #delete promo
      def promos_delete(current_user, id)
        @access_token = prepare_access_token(current_user.token, current_user.secret)
        @response = @access_token.request(:post, @site + "/1/promos/destroy", :id => id)        
        @promos = JSON.parse(@response.body())["promos"]
      end
      
      #create promo
      def promos_create(current_user, name, description, price, places_id)
        @access_token = prepare_access_token(current_user.token, current_user.secret)
        @response = @access_token.request(:post, @site + "/1/promos/create", :name => name,
                                                      :description=>description, :price=>price,
                                                      :places_id=>places_id)        
        @promos = JSON.parse(@response.body())["promos"]
      end
      
      #create promo
      def promos_create_with_rrule(current_user, name, description, price, places_id, rrule)
        @access_token = prepare_access_token(current_user.token, current_user.secret)
        @response = @access_token.request(:post, @site + "/1/promos/create", :name => name,
                                                      :description=>description, :price=>price,
                                                      :places_id=>places_id, :rrule=>rrule)        
        @promos = JSON.parse(@response.body())["promos"]
      end
      
      
       #show available quests
      def quests_available(current_user)
        @access_token = prepare_access_token(current_user.token, current_user.secret)
        @response = @access_token.request(:post, @site + "/1/quests/available")
        @quests = JSON.parse(@response.body())["quests"]
      end
            
    end
 end