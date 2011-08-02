module BookytPos
  module Navigation
    def setup_bookyt_pos(navigation)
      navigation.item :store, I18n::translate('bookyt.main_navigation.store'), new_day_path,
                   :tooltip => I18n::translate('bookyt.main_navigation.tooltip.store'),
                   :if => Proc.new { user_signed_in? } do |store|
        store.item :day, I18n::translate('bookyt.main_navigation.days'), days_path,
                   :tooltip => I18n::translate('bookyt.main_navigation.tooltip.days'),
                   :highlights_on => /\/days($|\?)/
        store.item :day, I18n::translate('bookyt.main_navigation.new_day'), new_day_path,
                   :tooltip => I18n::translate('bookyt.main_navigation.tooltip.new_day'),
                   :highlights_on => /\/days\/new/
      end
    end
  end
end
