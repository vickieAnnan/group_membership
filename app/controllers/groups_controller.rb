class GroupsController < ApplicationController

    def index
        @groups = Group.all
        @user = User.find(session[:user_id])
        @attendee = Attendee.all

    end

    def create
        @group = Group.new
        @group.org_name = params[:org_name]
        @group.description = params[:description]
        @group.user = current_user
        if @group.save
            @insertedGroup_id = Group.maximum('id')
            @currentGroup=Group.find_by(org_name:@group.org_name)
            if do_join(@currentGroup,current_user)
                redirect_to '/groups'
            else 
                flash[:errors] = @group.errors.full_messages
                redirect_to '/groups'    
            end   
            # redirect_to '/groups'
        else
            flash[:errors] = @group.errors.full_messages
            redirect_to '/groups'
        end
    end

    def show
        @group = Group.find(params[:id])
        @attendee = Attendee.all
    end

    def join
        if do_join(Group.find(params[:id]),current_user)
            redirect_back(fallback_location: '/groups')
        else 
            # flash[:errors] = @group.errors.full_messages
            redirect_to '/groups'
        end    
        
           
       

    end
    def leave
        @attendee = Attendee.find_by(user_id: current_user)
        if @attendee
            @attendee.destroy
            redirect_back(fallback_location: '/groups')
        else
            redirect_to '/groups'    
        end
    end
    def delete_group
        @group = Group.find_by(id: params[:id])
        if @group
            @group.destroy
            redirect_back(fallback_location: '/groups')
        else
            redirect_to '/groups'    
        end
    end

    def do_join(group_id,user_id)
        @attendee = Attendee.find_by(group_id:group_id,user_id: user_id)
        if @attendee
            return false

        else 
            @attendee = Attendee.new
            @attendee.user = user_id
            @attendee.group = group_id
            if @attendee.save
                return true
            else
                return false
            end  
        end     
    end
    # private
    #     def groups_params
    #         params.require(:group).permit(:org_name, :description)
    #     end
end
