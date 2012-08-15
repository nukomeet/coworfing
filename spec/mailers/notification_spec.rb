require "spec_helper"

describe Notification do
  describe 'request_notification_email' do
    let(:regular) { FactoryGirl.create(:user, :regular) }
    let(:mail) { Notification.request_notification_email(regular) }
    
    #ensure that the subject is correct
    it 'renders the subject' do
      mail.subject.should == 'Coworfing Request Pending'
    end

    #ensure that the receiver is correct
    it 'renders the receiver email' do
      mail.to.should == [regular.email]
    end
 
    #ensure that the sender is correct
    it 'renders the sender email' do
      mail.from.should == ["bonjour@nukomeet.com"]
    end
    
    it 'should be sendable' do
      ActionMailer::Base.deliveries.should be_empty
      mail.deliver
      ActionMailer::Base.deliveries.inspect.should_not be_empty
    end 
  end  
  
  describe 'request_confirmation_email' do
    let(:regular) { FactoryGirl.create(:user, :regular) }
    let(:mail) { Notification.request_confirmation_email(regular) }
    
    #ensure that the subject is correct
    it 'renders the subject' do
      mail.subject.should == 'Your coworfing request has been accepted'
    end

    #ensure that the receiver is correct
    it 'renders the receiver email' do
      mail.to.should == [regular.email]
    end
 
    #ensure that the sender is correct
    it 'renders the sender email' do
      mail.from.should == ["bonjour@nukomeet.com"]
    end
    
    it 'should be sendable' do
      ActionMailer::Base.deliveries.should be_empty
      mail.deliver
      ActionMailer::Base.deliveries.inspect.should_not be_empty
    end 
  end  
  
  describe 'comment_email' do
    let(:regular) { FactoryGirl.create(:user, :regular) }
    let(:mail) { Notification.comment_email(regular) }
    
    #ensure that the subject is correct
    it 'renders the subject' do
      mail.subject.should == 'There is a new comment on your place'
    end

    #ensure that the receiver is correct
    it 'renders the receiver email' do
      mail.to.should == [regular.email]
    end
 
    #ensure that the sender is correct
    it 'renders the sender email' do
      mail.from.should == ["bonjour@nukomeet.com"]
    end
    
    it 'should be sendable' do
      ActionMailer::Base.deliveries.should be_empty
      mail.deliver
      ActionMailer::Base.deliveries.inspect.should_not be_empty
   end
  end
  
  describe 'become_cow_email' do
    let(:regular) { FactoryGirl.create(:user, :regular) }
    let(:mail) { Notification.become_cow_email(regular) }
    
    #ensure that the subject is correct
    it 'renders the subject' do
      mail.subject.should == 'Congratulations, you just reached the Cow status!'
    end

    #ensure that the receiver is correct
    it 'renders the receiver email' do
      mail.to.should == [regular.email]
    end
 
    #ensure that the sender is correct
    it 'renders the sender email' do
      mail.from.should == ["bonjour@nukomeet.com"]
    end
    
    it 'should be sendable' do
      ActionMailer::Base.deliveries.should be_empty
      mail.deliver
      ActionMailer::Base.deliveries.inspect.should_not be_empty
   end
  end  
end
