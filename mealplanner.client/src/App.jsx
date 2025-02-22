import React, { useState } from 'react';
import { PlusCircle, Search, ChefHat } from 'lucide-react';

const MealPlanner = () => {
    const [ingredients, setIngredients] = useState([]);
    const [recipes, setRecipes] = useState([]);
    const [newIngredient, setNewIngredient] = useState({ name: '', quantity: '', unit: '' });
    const [suggestedMeals, setSuggestedMeals] = useState([]);

    const addIngredient = () => {
        if (newIngredient.name && newIngredient.quantity && newIngredient.unit) {
            setIngredients([...ingredients, newIngredient]);
            setNewIngredient({ name: '', quantity: '', unit: '' });
        }
    };

    const findPossibleMeals = () => {
        // This would eventually call your C# backend
        console.log("Finding meals based on:", ingredients);
    };

    return (
        <div className="max-w-4xl mx-auto p-6">
            <div className="space-y-8">
                {/* Header */}
                <div className="text-center">
                    <h1 className="text-3xl font-bold">Meal Planner</h1>
                    <p className="text-gray-600">Plan your meals based on available ingredients</p>
                </div>

                {/* Ingredient Input Section */}
                <div className="bg-white p-6 rounded-lg shadow">
                    <h2 className="text-xl font-semibold mb-4">Add Ingredients</h2>
                    <div className="flex gap-4 mb-4">
                        <input
                            type="text"
                            placeholder="Ingredient name"
                            className="flex-1 p-2 border rounded"
                            value={newIngredient.name}
                            onChange={(e) => setNewIngredient({ ...newIngredient, name: e.target.value })}
                        />
                        <input
                            type="number"
                            placeholder="Quantity"
                            className="w-24 p-2 border rounded"
                            value={newIngredient.quantity}
                            onChange={(e) => setNewIngredient({ ...newIngredient, quantity: e.target.value })}
                        />
                        <select
                            className="w-24 p-2 border rounded"
                            value={newIngredient.unit}
                            onChange={(e) => setNewIngredient({ ...newIngredient, unit: e.target.value })}
                        >
                            <option value="">Unit</option>
                            <option value="g">grams</option>
                            <option value="kg">kg</option>
                            <option value="ml">ml</option>
                            <option value="l">liters</option>
                            <option value="pcs">pieces</option>
                        </select>
                        <button
                            onClick={addIngredient}
                            className="bg-blue-500 text-white p-2 rounded hover:bg-blue-600"
                        >
                            <PlusCircle className="w-6 h-6" />
                        </button>
                    </div>

                    {/* Ingredients List */}
                    <div className="space-y-2">
                        {ingredients.map((ingredient, index) => (
                            <div key={index} className="flex items-center justify-between bg-gray-50 p-2 rounded">
                                <span>{ingredient.name}</span>
                                <span>{ingredient.quantity} {ingredient.unit}</span>
                            </div>
                        ))}
                    </div>
                </div>

                {/* Find Meals Button */}
                <button
                    onClick={findPossibleMeals}
                    className="w-full bg-green-500 text-white p-4 rounded-lg hover:bg-green-600 flex items-center justify-center gap-2"
                >
                    <ChefHat className="w-6 h-6" />
                    Find Possible Meals
                </button>

                {/* Suggested Meals Section */}
                <div className="bg-white p-6 rounded-lg shadow">
                    <h2 className="text-xl font-semibold mb-4">Suggested Meals</h2>
                    {suggestedMeals.length === 0 ? (
                        <p className="text-gray-500 text-center">No meals suggested yet</p>
                    ) : (
                        <div className="space-y-2">
                            {suggestedMeals.map((meal, index) => (
                                <div key={index} className="p-2 border rounded">
                                    {meal.name}
                                </div>
                            ))}
                        </div>
                    )}
                </div>
            </div>
        </div>
    );
};

export default MealPlanner;