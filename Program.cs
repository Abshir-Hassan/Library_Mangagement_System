using Microsoft.EntityFrameworkCore;
using Library_Mangagement_System.Data;
using Library_Mangagement_System.Models;
using Pomelo.EntityFrameworkCore.MySql.Infrastructure;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
builder.Services.AddControllersWithViews();

// Add DbContext with detailed error handling and Turkish character support
builder.Services.AddDbContext<LibraryDbContext>(options =>
{
    var connectionString = builder.Configuration.GetConnectionString("DefaultConnection");
    options.UseMySql(
        connectionString,
        ServerVersion.AutoDetect(connectionString),
        mySqlOptions => mySqlOptions
            .EnableRetryOnFailure(
                maxRetryCount: 10,
                maxRetryDelay: TimeSpan.FromSeconds(30),
                errorNumbersToAdd: null)
    );
});

var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseDeveloperExceptionPage();
}
else
{
    app.UseExceptionHandler("/Home/Error");
    // The default HSTS value is 30 days. You may want to change this for production scenarios, see https://aka.ms/aspnetcore-hsts.
    app.UseHsts();
}

app.UseHttpsRedirection();
app.UseStaticFiles();

app.UseRouting();

// Configure endpoints
app.MapControllerRoute(
    name: "default",
    pattern: "{controller=Home}/{action=Dashboard}/{id?}");

// Ensure database is created and tables are initialized
using (var scope = app.Services.CreateScope())
{
    var services = scope.ServiceProvider;
    try
    {
        var context = services.GetRequiredService<LibraryDbContext>();
        context.Database.EnsureCreated();

        // Check if we have any data
        if (!context.Kategoriler.Any())
        {
            // Add some initial categories
            context.Kategoriler.AddRange(
                new Kategori { Kategori_Adi = "Roman" },
                new Kategori { Kategori_Adi = "Bilim" },
                new Kategori { Kategori_Adi = "Tarih" },
                new Kategori { Kategori_Adi = "Edebiyat" }
            );
            context.SaveChanges();
        }

        Console.WriteLine("Veritabanı başarıyla oluşturuldu.");
    }
    catch (Exception ex)
    {
        var logger = services.GetRequiredService<ILogger<Program>>();
        logger.LogError(ex, "Veritabanı oluşturulurken bir hata oluştu.");
        Console.WriteLine($"Veritabanı hatası: {ex.Message}");
        throw; // Rethrow to ensure the application fails fast if database initialization fails
    }
}

app.Run();
