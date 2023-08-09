class ExpensesController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  def index
    @expenses = Expense.all
  end

  def show
    @expense = Expense.find(params[:id])
    render json: @expense
  end

  def new
    @expense = Expense.new
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

  def expense_params
    params.require(:expense).permit(:name, :amount, :group_id)
  end

end
