class ExpensesController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource
  rescue_from CanCan::AccessDenied do |_exception|
    flash[:alert] = 'You are not authorized to proceed with your request.'
    redirect_to expenses_path # You can redirect to any page you prefer
  end


  def index
    @expenses = current_user.expenses.where(group_id: params[:group_id]) if params[:group_id].present?
    @group = Group.find(params[:group_id]) if params[:group_id].present?

    @amount = @expenses.sum(:amount)
  end

  def show
    @expense = Expense.find(params[:id])
    # render json: @expense
  end

  def new
    @expense = Expense.new(group_ids: [params[:group_id]])
  end

  def create
    @expense = current_user.expenses.new(expense_params)

    respond_to do |format|
      if @expense.save
        format.html { redirect_to expense_url(@expense), notice: 'Expense was successfully created.' }
        format.json { render :show, status: :created, location: @expense }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @expense.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
    @expense = Expense.find_by_id(params[:id])
  end

  def update
    respond_to do |format|
      if @expense.update(expense_params)
        format.html { redirect_to expense_url(@expense), notice: 'Exspence successfully updated.' }
        format.json { render :show, status: :ok, location: @expense }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @expense.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @expense.destroy

    respond_to do |format|
      format.html { redirect_to expenses_url, notice: 'Expense was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_expense
    @expense = Expense.find(params[:id])
  end

  def set_group
    @group = Group.find(params[:group_id])
  end

  def expense_params
    params.require(:expense).permit(:name, :amount, :group_id)
  end

  def group_total_expenses_amount; end
end
