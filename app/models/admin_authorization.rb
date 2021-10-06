class AdminAuthorization < ActiveAdmin::AuthorizationAdapter

  def authorized?(action, subject = nil)
    resources = ActiveAdmin::ManageableResource.call.map {|t| t[:class_name]}
    if resources.include?(subject.class.to_s)
      user.available_actions(subject.class.to_s).include?(action.to_s)
    else
      true
    end
  end

end