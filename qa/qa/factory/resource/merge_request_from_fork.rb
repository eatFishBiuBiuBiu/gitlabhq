module QA
  module Factory
    module Resource
      class MergeRequestFromFork < MergeRequest
        attr_accessor :fork_branch

        attribute :fork do
          Factory::Resource::Fork.fabricate!
        end

        attribute :push do
          Factory::Repository::ProjectPush.fabricate! do |resource|
            resource.project = fork
            resource.branch_name = fork_branch
            resource.file_name = 'file2.txt'
            resource.user = fork.user
          end
        end

        def fabricate!
          push
          fork.visit!
          Page::Project::Show.perform(&:new_merge_request)
          Page::MergeRequest::New.perform(&:create_merge_request)
        end
      end
    end
  end
end
