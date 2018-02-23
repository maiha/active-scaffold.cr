- if record.errors.any?
  - record.errors.each do |err|
    li.alert-danger= err.to_s
