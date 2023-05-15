class CommentsController < ApplicationController

    def create
        @combo        = Combo.find(params[:combo_id])
        @comment      = @combo.comments.build(comment_params)
        @comment.user = current_user
        if @comment.save
            flash[:success] = "コメントを投稿しました"
            redirect_to combo_path(@combo)
        else
            flash[:danger] = "コメントの投稿に失敗しました"
            redirect_to combo_path(@combo)
        end
    end

    def destroy
        @combo   = Combo.find(params[:combo_id])
        @comment = Comment.find(params[:id])
        @comment.destroy
        flash[:success] = "コメントを削除しました"
        redirect_to combo_path(@combo)
    end

    private

    def comment_params
        params.require(:comment).permit(:body)
    end
end
