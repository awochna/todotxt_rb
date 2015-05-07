module TodotxtRb
  class List < Array

    def intialize(tasks)
      tasks.each do |task|
        self.push task
      end
    end

    def projects
      array = []
      self.each do |task|
        array.push task.projects
      end
      array.flatten.uniq.sort
    end

    def contexts
      array = []
      self.each do |task|
        array.push task.contexts
      end
      array.flatten.uniq.sort
    end

    def has_project?(project)
      self.projects.include? project
    end

    def has_context?(context)
      self.contexts.include? context
    end

    def completed
      array = self.select { |task| task.done? }
      TodotxtRb::List.new(array)
    end

    def incomplete
      array = self.reject { |task| task.done? }
      TodotxtRb::List.new(array)
    end

    def to_str
      string = ""
      index = 1
      self.each do |task|
        string += "#{index} #{task}\n"
        index += 1
      end
      string
    end

    alias_method :to_s, :to_str

    def filter(matcher)
      array = []
      self.each do |task|
        array.push task if task.to_s.include?(matcher)
      end
      TodotxtRb::List.new(array)
    end
  end
end
