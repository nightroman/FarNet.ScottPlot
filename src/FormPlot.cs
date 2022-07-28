using ScottPlot;
using System;
using System.Diagnostics;
using System.Threading;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace FarNet.ScottPlot;

/// <summary>
/// This type extends <see cref="Plot"/> with members for showing the plot in a form.
/// </summary>
public class FormPlot : Plot
{
    readonly CancellationTokenSource _tokenSource = new();
    private string _formTitle;
    FormsPlotViewer _form;

    /// <summary>
    /// Gets or sets the form title.
    /// </summary>
    public string FormTitle
    {
        get => _formTitle;
        set
        {
            _formTitle = value;
            if (_form is not null)
                _form.Text = _formTitle;
        }
    }

    /// <summary>
    /// Gets the cancellation token for live plot tasks.
    /// </summary>
    public CancellationToken CancellationToken { get; }

    /// <summary>
    /// Gets true if the form is cancelling.
    /// </summary>
    public bool IsCancellationRequested => CancellationToken.IsCancellationRequested;

    /// <summary>
    /// Creates a new plot for showing in a form.
    /// </summary>
    /// <param name="formTitle">Specifies the form window title.</param>
    public FormPlot(string formTitle = null)
    {
        CancellationToken = _tokenSource.Token;
        FormTitle = formTitle;
    }

    /// <summary>
    /// Calls <see cref="Show()"/> and delays for the specified number of milliseconds.
    /// </summary>
    public Task ShowAsync(int millisecondsDelay)
    {
        Show();
        return Task.Delay(millisecondsDelay, CancellationToken);
    }

    /// <summary>
    /// Calls <see cref="Show()"/> and blocks the current thread for the specified number of milliseconds.
    /// In async contexts consider using <see cref="ShowAsync"/> instead.
    /// </summary>
    /// <param name="millisecondsWait">The number of milliseconds to wait or -1 to wait indefinitely.</param>
    public void Show(int millisecondsWait)
    {
        Show();

        //! valid 0 case: `$plot.Show($(if ($Wait) {-1} else {0}))`
        if (millisecondsWait != 0)
            CancellationToken.WaitHandle.WaitOne(millisecondsWait);
    }

    /// <summary>
    /// Shows this plot in a form or renders the shown form after plot changes.
    /// </summary>
    /// <remarks>
    /// This method shows the form and returns immediately.
    /// In order to block the current thread until the form is closed call <see cref="Show(int)"/> with -1.
    /// </remarks>
    public void Show()
    {
        if (_form is null)
        {
            var thread = new Thread(Start)
            {
                Name = "Plot thread.",
                IsBackground = true
            };
            thread.SetApartmentState(ApartmentState.STA);
            thread.Start();
        }
        else
        {
            if (CancellationToken.IsCancellationRequested)
                return;

            try
            {
                // Use `Invoke()` to avoid 'Cross-thread operation not valid: Control 'pictureBox1' accessed from a thread other than the thread it was created on.'
                _form.formsPlot1.Invoke(() => _form.formsPlot1.Render());
            }
            catch (InvalidOperationException ex)
            {
                // "Object is currently in use elsewhere." was seen and silenced before using above `Invoke()`.
                // This `catch` might be not needed anymore. But keep it for now.
                Trace.WriteLine($"ScottPlot error: {ex.Message}");
            }
        }
    }

    void Start()
    {
        _form = new FormsPlotViewer(this, (int)Width, (int)Height, FormTitle ?? "Plot");

        _form.Load += (s, e) =>
        {
            _form.Activate();
        };

        _form.formsPlot1.KeyDown += (s, e) =>
        {
            if (e.KeyCode == Keys.Escape)
            {
                _tokenSource.Cancel();
                _form.Close();
            }
        };

        try
        {
            _form.ShowDialog();
        }
        finally
        {
            _tokenSource.Cancel();
            _form.Dispose();
        }
    }
}
