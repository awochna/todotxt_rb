require 'spec_helper'

describe TodotxtRb::List do

  def create_tasks
    file = 'spec/todo.txt'
    array = []
    File.open(file) do |file|
      file.each_line do |line|
        array.push(TodotxtRb::Task.new(line.chomp))
      end
    end
    array
  end

  it "takes an array of tasks" do
      task = TodotxtRb::Task.new('Clean desk')
      expect { TodotxtRb::List.new([task]) }.to_not raise_error
  end

  let!(:list) { TodotxtRb::List.new(create_tasks) }

  subject { list }

  specify "sanity" do
    expect(list[0].to_str).to eq "(A) 2015-04-28 Clean desk @home"
  end

  describe "interface" do
    it { is_expected.to respond_to :projects }
    it { is_expected.to respond_to :contexts }
    it { is_expected.to respond_to :completed }
    it { is_expected.to respond_to :incomplete }
    it { is_expected.to respond_to :length }
  end

  it "should contain tasks" do
    list.each do |task|
      expect(task).to be_instance_of TodotxtRb::Task
    end
  end

  it { is_expected.to have_context '@work' }
  it { is_expected.to have_context '@home' }
  it { is_expected.to have_context '@boss' }
  it { is_expected.to have_project '+NewApp' }
  it { is_expected.to have_project '+NewSiteProject' }

  it "can list it's projects" do
    expect(list.projects).to eq ['+NewApp','+NewSiteProject']
  end

  it "can list it's contexts" do
    expect(list.contexts).to eq ['@boss', '@home', '@work']
  end

  it "can give a new list of it's incomplete tasks" do
    expect(list.incomplete.length).to eq 3
  end

  it "can give a new list of it's complete tasks" do
    expect(list.completed.length).to eq 1
  end

  it "converts to string nicely" do
    string = "(A) 2015-04-28 Clean desk @home"
    expect(list.to_str).to include string
  end

  describe "prints out" do

    specify "nicely" do
      string = "(A) 2015-04-28 Clean desk @home"
      expect(list.to_s).to include string
    end

    specify "with line numbers" do
      string = "1 (A) 2015-04-28 Clean desk @home"
      expect(list.to_s).to include string
    end
  end

  describe "can filter" do

    specify "tasks with @work context" do
      expect(list.filter('@work').length).to eq 3
    end

    specify "tasks with +NewSite project" do
      expect(list.filter('+NewSite').length).to eq 1
    end

    specify "tasks with an arbitrary word" do
      expect(list.filter('Clean').length).to eq 1
    end
  end
end
