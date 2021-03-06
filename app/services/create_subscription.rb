class CreateSubscription
  def self.call(params)
    plan = Plan.find_by_amount(params[:plan])

    sub = Subscription.new do |s|
      s.plan = plan
    end

    if sub.save
      ProcessSubscriptionJob.perform_later sub.id
    end

    sub
  end
end
