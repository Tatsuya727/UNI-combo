class CommentsController < ApplicationController

    def create
        @combo   = Combo.find(params[:combo_id])
        @comment = @combo.comments.build(comment_params)
        if @comment.save
            redirect_to @combo
        else
            redirect_to @combo
        end
    end

    private

    def comment_params
        params.require(:comment).permit(:content)
    end
end
